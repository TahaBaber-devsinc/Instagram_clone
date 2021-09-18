# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      StoryJob.set(wait_until: @story.expiry).perform_later(@story)
    else
      flash[:notice] = 'Can not add the story'
    end

    redirect_to user_stories_path
  end

  def destroy
    @story = current_user.stories.find(params[:id])
    flash[:notice] = 'Story not found' unless @story.destroy
    redirect_to user_stories_path
  end

  def new
    @story = current_user.stories.new
  end

  def index
    @user = User.find(params[:user_id])
    @stories = @user.stories
  end

  private

  def story_params
    params.require(:story).permit(:image)
  end
end

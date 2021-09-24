# frozen_string_literal: true

# class for user stories
class StoriesController < ApplicationController
  before_action :authenticate_user!
  def create
    story = current_user.stories.new(story_params)
    if story.save
      StoryJob.set(wait_until: story.expiry).perform_later(story)
      redirect_to user_stories_path
    else
      error_messages(story) and redirect_to new_user_story_path
    end
  end

  def destroy
    story = Story.find(params[:id])
    authorize story
    flash[:notice] = 'Story not found' unless story.destroy
    redirect_to user_stories_path
  end

  def new
    @story = current_user.stories.new
  end

  def index
    user = User.find(params[:user_id])
    @stories = user.stories
    authorize(user, policy_class: StoryPolicy)
  end

  private

  def story_params
    return nil if params[:story].nil?

    params.require(:story).permit(:image)
  end
end

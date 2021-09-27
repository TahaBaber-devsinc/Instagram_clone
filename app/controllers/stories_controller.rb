# frozen_string_literal: true

# class for user stories
class StoriesController < ApplicationController
  def create
    story = current_user.stories.new(story_params)
    authorize story

    redirect_to user_stories_path, flash: { notice: 'Added successfully' } and return if story.save

    error_messages(story) and redirect_to new_user_story_path
  end

  def destroy
    story = Story.find(params[:id])
    authorize story
    flash[:notice] = story.destroy ? 'destroyed successfully' : 'Story not found'
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

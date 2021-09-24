# frozen_string_literal: true

# job to destroy story after a day
class StoryJob < ApplicationJob
  queue_as :default

  def perform(story)
    story.destroy
  end
end

# frozen_string_literal: true

# model class for stories
class Story < ApplicationRecord
  # add expiry validation to be a future date
  validates :user_id, presence: true
  validates :image, attached: true, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/webp']
  belongs_to :user

  has_one_attached :image, dependent: :destroy

  after_create do
    StoryJob.set(wait: 24.hours).perform_later(self)
  end
end

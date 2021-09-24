# frozen_string_literal: true

# model class for stories
class Story < ApplicationRecord
  validates :user_id, presence: true
  validates :image, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/webp'] }

  belongs_to :user

  has_one_attached :image, dependent: :destroy

  after_initialize do
    self.expiry ||= 24.hours.from_now
  end
end

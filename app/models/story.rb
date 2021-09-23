# frozen_string_literal: true

class Story < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user

  has_one_attached :image, dependent: :destroy

  after_initialize do
    self.expiry ||= 24.hours.from_now
  end
end

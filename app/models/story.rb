# frozen_string_literal: true

class Story < ApplicationRecord
  # validations
  validates :user_id, presence: true

  # associations
  belongs_to :user

  has_one_attached :image
end

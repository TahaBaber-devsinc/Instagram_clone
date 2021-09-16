# frozen_string_literal: true

class Post < ApplicationRecord
  # Validations
  validates :user_id, presence: true
  validate :image_presence

  # Associations
  has_many :comments
  has_many :likes, as: :likable

  belongs_to :user

  has_many_attached :images

  private

  def image_presence
    errors.add(:images, 'Please add images') unless images.attached?
  end
end

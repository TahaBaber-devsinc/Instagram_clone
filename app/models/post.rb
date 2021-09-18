# frozen_string_literal: true

class Post < ApplicationRecord
  # Validations
  validates :user_id, presence: true
  validate :image_presence

  # Associations
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  belongs_to :user

  has_many_attached :images, dependent: :destroy

  private

  def image_presence
    errors.add(:images, 'Please add images') unless images.attached?
  end
end

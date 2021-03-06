# frozen_string_literal: true

# model class for posts
class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :images, attached: true, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/webp']
  validate :image_cap

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_many_attached :images, dependent: :destroy

  private

  def image_cap
    errors.add(:images, 'Images cannot be more than 10') if images.count > 10
  end
end

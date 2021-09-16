class Post < ApplicationRecord
  # Validations
  validates :user_id, presence: true

  # Associations
  has_many :comments
  has_many :likes, as: :likable

  belongs_to :user

  has_many_attached :images
end

# frozen_string_literal: true

class Comment < ApplicationRecord
  # Validations
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true

  # Associations
  has_many :likes, as: :likable

  belongs_to :user
  belongs_to :post
end

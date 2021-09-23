# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :body, presence: true

  belongs_to :user
  belongs_to :post

  has_many :likes, as: :likable, dependent: :destroy
end

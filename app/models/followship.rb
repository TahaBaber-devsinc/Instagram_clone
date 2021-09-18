# frozen_string_literal: true

class Followship < ApplicationRecord
  # Validations
  validates :user_id, presence: true
  validates :following_id, presence: true

  # Associations
  belongs_to :user
  belongs_to :followee, class_name: 'User', foreign_key: 'following_id'
end

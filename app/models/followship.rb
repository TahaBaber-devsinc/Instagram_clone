# frozen_string_literal: true

class Followship < ApplicationRecord
  validates :user_id, presence: true
  validates :following_id, presence: true

  belongs_to :user
  belongs_to :followee, class_name: 'User', foreign_key: 'following_id'
end

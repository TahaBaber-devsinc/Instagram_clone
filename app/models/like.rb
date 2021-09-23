# frozen_string_literal: true

class Like < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :likable, polymorphic: true
  belongs_to :user
end

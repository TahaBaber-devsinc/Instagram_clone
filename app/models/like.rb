class Like < ApplicationRecord
  # Validations
  validates :user_id, presence: true

  # Associations
  belongs_to :likable, polymorphic: true
end

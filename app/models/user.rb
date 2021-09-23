# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model

  enum account_type: {
    Public: 0,
    Private: 1
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :posts, dependent: :destroy

  has_many :stories, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :requests, dependent: :destroy

  has_many :followships
  has_many :followees, through: :followships, dependent: :destroy

  has_many :inverse_followships, class_name: 'Followship', foreign_key: 'following_id'
  has_many :followers, through: :inverse_followships, source: :user, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  pg_search_scope :search, against: %i[username email], using: {
    tsearch: { prefix: true }
  }
end

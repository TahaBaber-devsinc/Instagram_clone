# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum account_type: {
    Public: 0,
    Private: 1
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validations
  validates :username, presence: true

  # self Association relation with User as followee
  has_many :followships
  has_many :followees, through: :followships, dependent: :destroy

  has_many :inverse_followships, class_name: 'Followship', foreign_key: 'following_id'
  has_many :followers, through: :inverse_followships, source: :user, dependent: :destroy

  # one-many association with posts
  has_many :posts, dependent: :destroy

  # one-many association with story
  has_many :stories, dependent: :destroy

  # one-many association with comment
  has_many :comments, dependent: :destroy

  # one-many association with comment
  has_many :likes, dependent: :destroy

  # one-many association with request
  has_many :requests, dependent: :destroy

  has_one_attached :image, dependent: :destroy
end

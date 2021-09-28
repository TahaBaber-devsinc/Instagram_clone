# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
    add_foreign_key :followships, :users
    add_foreign_key :likes, :users
    add_foreign_key :posts, :users
    add_foreign_key :requests, :users
    add_foreign_key :stories, :users
  end
end

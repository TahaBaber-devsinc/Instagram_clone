# frozen_string_literal: true

class AddIndexToForeignKeys < ActiveRecord::Migration[6.1]
  def change
    add_index :stories, :user_id
    add_index :followships, :user_id
    add_index :followships, :following_id
    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end

# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string  :body

      t.timestamps
    end
    add_index :posts, :user_id
  end
end

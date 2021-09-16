# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.references :likable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end

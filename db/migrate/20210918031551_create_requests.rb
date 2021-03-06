# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :followee_id

      t.timestamps
    end
  end
end

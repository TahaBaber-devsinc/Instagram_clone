# frozen_string_literal: true

class RemovePictureFromUser < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :profile_picture
  end

  def down; end
end

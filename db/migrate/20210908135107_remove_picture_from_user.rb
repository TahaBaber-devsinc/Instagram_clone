# frozen_string_literal: true

class RemovePictureFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :profile_picture
  end
end

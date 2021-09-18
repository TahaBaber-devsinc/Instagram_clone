# frozen_string_literal: true

class AddExpiryToStory < ActiveRecord::Migration[6.1]
  def change
    add_column :stories, :expiry, :datetime
  end
end

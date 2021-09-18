# frozen_string_literal: true

class MakeExpiryNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :stories, :expiry, false
  end
end

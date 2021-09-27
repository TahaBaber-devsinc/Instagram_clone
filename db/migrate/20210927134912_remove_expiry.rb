class RemoveExpiry < ActiveRecord::Migration[6.1]
  def up
    remove_column :stories, :expiry
  end

  def down; end
end

class MakeColumnsNotNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :followships, :user_id, false
    change_column_null :followships, :following_id, false
    change_column_null :posts, :user_id, false
    change_column_null :stories, :user_id, false
  end
end

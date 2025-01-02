class ChangeUserIdToAllowNullInTests < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tests, :user_id, true
  end
end

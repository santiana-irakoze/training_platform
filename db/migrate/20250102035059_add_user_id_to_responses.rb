class AddUserIdToResponses < ActiveRecord::Migration[7.1]
  def change
    add_reference :responses, :user, null: true, foreign_key: true
  end
end

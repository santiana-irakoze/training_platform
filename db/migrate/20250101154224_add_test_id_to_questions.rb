class AddTestIdToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :test_id, :bigint
    add_foreign_key :questions, :tests
    add_index :questions, :test_id
  end
end

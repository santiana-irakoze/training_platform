class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.references :question, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.string :chosen_option
      t.boolean :is_correct

      t.timestamps
    end
  end
end

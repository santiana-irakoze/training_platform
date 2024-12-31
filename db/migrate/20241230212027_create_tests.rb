class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score
      t.integer :duration
      t.datetime :date

      t.timestamps
    end
  end
end

class AddTimeTakenToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :time_taken, :integer
  end
end

class AddNameToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :Name, :string
  end
end

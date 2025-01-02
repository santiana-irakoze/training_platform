class AddFormatToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :format, :string
  end
end

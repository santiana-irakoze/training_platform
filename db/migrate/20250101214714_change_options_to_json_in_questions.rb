class ChangeOptionsToJsonInQuestions < ActiveRecord::Migration[7.1]
  def change
    change_column :questions, :options, :jsonb, default: [], using: 'options::jsonb'
  end
end

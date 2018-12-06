class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :favorites, :quote_id, :integer
  end
end

class AddUniquenessForTastings < ActiveRecord::Migration
  def up
    add_index :tastings, [:user_id, :wine_id], :unique => true
  end

  def down
    remove_index :tastings, [:user_id, :wine_id]
  end
end

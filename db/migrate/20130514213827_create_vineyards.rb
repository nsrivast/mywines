class CreateVineyards < ActiveRecord::Migration
  def change
    create_table :vineyards do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.integer :user_id
      t.integer :subregion_id

      t.timestamps
    end
  end
end

class CreateSubregions < ActiveRecord::Migration
  def change
    create_table :subregions do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.integer :user_id
      t.integer :region_id

      t.timestamps
    end
  end
end

class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :lat
      t.string :lng
      t.integer :user_id
      t.integer :country_id

      t.timestamps
    end
  end
end

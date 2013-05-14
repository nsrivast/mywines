class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name
      t.float :price
      t.binary :photo
      t.integer :vintage
      t.string :varietal
      t.string :purchased
      t.integer :vineyard_id

      t.timestamps
    end
  end
end

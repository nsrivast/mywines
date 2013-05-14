class CreateTastings < ActiveRecord::Migration
  def change
    create_table :tastings do |t|
      t.integer :rating_first
      t.integer :rating_final
      t.string :color
      t.string :adjs_aroma
      t.string :adjs_taste
      t.string :adjs_aftertaste
      t.integer :trait_acidity
      t.integer :trait_astringency
      t.integer :trait_alcohol
      t.integer :trait_sweetness
      t.integer :trait_body
      t.integer :trait_intensity
      t.date :drank_on
      t.string :drank_after
      t.string :drank_with
      t.string :drank_again
      t.integer :user_id
      t.integer :wine_id

      t.timestamps
    end
  end
end

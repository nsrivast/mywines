class Tasting < ActiveRecord::Base
  attr_accessible :user_id, :wine_id, :adjs_aftertaste, :adjs_aroma, :adjs_taste, :color, :drank_after, :drank_again, :drank_on, :drank_with, :rating_final, :rating_first, :trait_acidity, :trait_alcohol, :trait_astringency, :trait_body, :trait_intensity, :trait_sweetness

  belongs_to :user
  belongs_to :wine
  
  validates_presence_of :trait_acidity, :trait_astringency, :trait_alcohol, :trait_sweetness, :trait_body, :trait_intensity
  validates_uniqueness_of :wine_id, :scope => :user_id
end

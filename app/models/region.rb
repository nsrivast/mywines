class Region < ActiveRecord::Base
  attr_accessible :country_id, :lat, :lng, :name, :user_id
  
  has_many :subregions
  has_many :wines, :through => :subregions
  belongs_to :country
  belongs_to :user
  
  
end

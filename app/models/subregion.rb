class Subregion < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :region_id, :user_id
  
  has_many :vineyards
  has_many :wines, :through => :vineyards
  belongs_to :region
  belongs_to :user
  
  
end

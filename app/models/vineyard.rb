class Vineyard < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :subregion_id, :user_id
  
  has_many :wines
  belongs_to :subregion
  belongs_to :user
  
end

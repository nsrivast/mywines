class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  has_many :tastings
  has_many :wines, :through => :tastings
  
  has_many :vineyards
  has_many :subregions
  has_many :regions
  has_many :countries
  
  
  validates :name, :presence => true  
end

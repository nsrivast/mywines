class Wine < ActiveRecord::Base
  attr_accessible :name, :photo, :price, :vineyard_id, :vintage, :varietal, :purchased
  attr_accessor :photo_file_name
  attr_accessor :photo_content_type
  attr_accessor :photo_file_size
  attr_accessor :photo_updated_at
  
  validates :name, :presence => true

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "20x20>" }, :default_url => "/images/default_wine.png"
  
  has_many :tastings, :dependent => :destroy
  has_many :users, :through => :tastings
  
  belongs_to :vineyard

  def get_heritage
    v = self.vineyard
    s = v.subregion
    r = s.region
    c = r.country
    return {:vineyard => v.name, :subregion => s.name, :region => r.name, :country => c.name}
  end
  
  def pretty_name
    "#{self.name} (#{self.varietal} - #{self.vineyard.subregion.region.name}, #{self.vineyard.subregion.region.country.name})"
  end
  
  def avg_rating
    tastings = self.tastings
    if tastings.length == 0
      return false
    else
      ratings = tastings.collect { |t| [t.rating_first, t.rating_final] }.flatten
      return ratings.inject(0.0) { |sum, elem| sum + elem } / ratings.length
    end
  end
end

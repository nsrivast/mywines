class Country < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :user_id
  
  has_many :regions
  has_many :wines, :through => :regions
  belongs_to :user
    
  def self.add_tuple(v,s,r,c)
    c = add_country(c)
    r = add_region(r, c.id)
    s = add_subregion(s, r.id)
    v = add_vineyard(v, s.id)
    
    return c
  end
  
  def self.add_country(c)
    c_try = Country.find_by_name(c)
    c = c_try ? c_try : Country.create({:name => c, :user_id => 0})
    return c
  end
  def self.add_region(r, c_id)
    r_try = Region.find_by_name(r)
    r = r_try ? r_try : Region.create({:name => r, :user_id => 0, :country_id => c_id})
    return r
  end
  def self.add_subregion(s, r_id)
    s_try = Subregion.find_by_name(s)
    s = s_try ? s_try : Subregion.create({:name => s, :user_id => 0, :region_id => r_id})
    return s
  end
  def self.add_vineyard(v, s_id)
    v_try = Vineyard.find_by_name(v)
    v = v_try ? v_try : Vineyard.create({:name => v, :user_id => 0, :subregion_id => s_id})
    return v
  end
    
    
end


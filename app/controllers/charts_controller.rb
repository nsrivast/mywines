class ChartsController < ApplicationController
  
  def all
    epoch_date = Date.new(1970,1,1)
    user = User.find_by_id(1)
    tastings = user.tastings
    
    @charts = [
      {
        :name => "rating_v_price",
        :title => "Rating vs Price",
        :subtitle => "all wines",
        :datetime => false,
        :x_axis => "Price ($)",
        :y_axis => "Rating",
        :data => Wine.all.collect{ |w| {
          :name => w.name,
          :click_name => w.pretty_name,
          :id => w.id,
          :x => w.price,
          :y => w.avg_rating
          }
        }
      },
      {
        :name => "price_v_time",
        :title => "Price Timeline",
        :subtitle => "all wines",
        :datetime => true,
        :x_axis => "Date Drank",
        :y_axis => "Price",
        :data => tastings.collect{ |t| {
          :name => t.wine.name,
          :click_name => t.wine.pretty_name,
          :id => t.wine.id,
          :x => t.drank_on,
          :y => t.wine.price,
          }
        }
      },
      {
        :name => "rating_v_time",
        :title => "Rating Timeline",
        :subtitle => "all wines",
        :datetime => true,
        :x_axis => "Date Drank",
        :y_axis => "Rating",
        :data => tastings.collect{ |t| {
          :name => t.wine.name,
          :click_name => t.wine.pretty_name,
          :id => t.wine.id,
          :x => t.drank_on,
          :y => t.wine.avg_rating
          }
        }
      }    
    ]
    
  end

end

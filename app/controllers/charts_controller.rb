class ChartsController < ApplicationController
  
  def all
    @charts = %w{rating_v_price price_v_time rating_v_time}
  end

  def rating_v_price
    @chart_data = Wine.all.collect{ |w| {:name => w.name, :scatter => [[w.price, w.avg_rating]] }}
  end
  def price_v_time
    epoch_date = Date.new(1970,1,1)
    user = User.find_by_id(1)
    @chart_data = user.tastings.collect { |t| 
      {:name => t.wine.name, :scatter => [[(t.drank_on - epoch_date).to_i, t.wine.price ]] }
    }
  end
  def rating_v_time
    epoch_date = Date.new(1970,1,1)
    user = User.find_by_id(1)
    @chart_data = user.tastings.collect { |t| 
      {:name => t.wine.name, :scatter => [[(t.drank_on - epoch_date).to_i, t.wine.avg_rating ]] }
    }
  end

end

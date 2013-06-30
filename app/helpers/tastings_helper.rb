module TastingsHelper

  def pretty_trait(trait, val)
    val_description = @trait_indices[trait.to_sym][val+3]
    val_strength = case val
    when 0
       "undistinguished"
    when 1
      "slightly strong"
    when 2
      "strong"
    when 3
      "very strong"
    when -1
      "slightly weak"
    when -2
      "weak"
    when -3
      "very weak"
    else
      ""
    end
    
    return "#{val}: #{val_description}"
  end
  
  def pretty_rating(i)
    
    return i ? "#{i}: #{@rating_index[i-1]}" : ""
  end
  
end

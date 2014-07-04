class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :assign_tasting_indices
  
  def assign_tasting_indices
    @rating_index = %w{terrible poor mediocre decent good great suberb}

    @colors = ["EAFF80", "FAFA7D", "FDEC7F", "F1D579", "6C0D31", "490921", "3D161B", "340611", "240D15"]
    @color_index = { 
      "EAFF80" => "pale yellow-green (sauvignon blanc, gruner veltliner, albarino, muscadet)",
      "FAFA7D" => "pale yellow-gold (unoaked chardonnay, pinot blanc, chenin blanc, viognier)",
      "FDEC7F" => "creamy yellow-gold (oaked chardonnay, verdejo)",
      "F1D579" => "yellow-brown (aged white wines, some dessert wines)",
      "6C0D31" => "ruby (young merlot, pinot noir, tempranillo, sangiovese)",
      "490921" => "garnet (cabernet sauvignon)",
      "3D161B" => "burgundy (burgundy, syrah, malbec)",
      "340611" => "ruddy brown (aged pinot noir, burgundy)",
      "240D15" => "deep purple (nebbiolo)"
    }
    
    @traits = %w{acidity astringency alcohol sweetness body intensity}
    @trait_indices = {
      :acidity => ["flaccid, dull", "flat, dim", "mild, soft", "balanced", "bright, fresh", "crisp, tart", "sharp, caustic"],
      :astringency => ["weak, spineless", "wet, soft", "smooth, round", "balanced", "structured, firm", "tannic, rough", "harsh, puckering"],
      :alcohol => ["weak, starved", "light, lean", "quiet, cool", "balanced", "full, punchy", "hot, hefty", "volatile, heavy"],
      :body => ["watery, breezy", "sparse, lean", "light, delicate", "balanced", "substantial, full", "rich, creamy", "flabby, oily"],
      :intensity => ["blank, weak", "reticent, sublte", "delicate, elegant", "balanced", "large, expansive", "bold, brash", "aggressive, overpowering"],
      :sweetness => ["parched, sour", "dry, brut", "crisp, clean", "balanced", "ripe", "sweet, decadent", "sugary, cloying"]
    }
  end
  
  # -- mobile device methods (from scottwb.com)
  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile #if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
  
end

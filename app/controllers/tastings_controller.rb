class TastingsController < ApplicationController
  # -- mobile device methods (from scottwb.com)
  before_filter :check_for_mobile
  
  # GET /tastings
  # GET /tastings.json
  
  def index
    @tastings = Tasting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tastings }
    end
  end

  # GET /tastings/1
  # GET /tastings/1.json
  def show
    @tasting = Tasting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tasting }
    end
  end

  # GET /tastings/new
  # GET /tastings/new.json
  def new
    @users = User.all
    @wines = Wine.find(:all, :order => "id DESC")
    
    @tasting = Tasting.new(
      :user_id => (params[:user_id_preselect] ? params[:user_id_preselect] : 1),
      :wine_id => (params[:wine_id_preselect] ? params[:wine_id_preselect] : 1)
      )
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tasting }
    end
  end
  
  def duplicate
    @users = User.all
    @wines = Wine.find(:all, :order => "id DESC")
    
    orig = Tasting.find(params[:id])
    @tasting = Tasting.new(orig.attributes.reject{ |k,v| k == "id" || k == "created_at" || k == "updated_at" })
    respond_to do |format|
      format.html
      format.json { render :json => @tasting }
    end
  end

  # GET /tastings/1/edit
  def edit
    @users = User.all
    @wines = Wine.all
    @tasting = Tasting.find(params[:id])
  end

  # POST /tastings
  # POST /tastings.json
  def create
    @tasting = Tasting.new(params[:tasting])

    respond_to do |format|
      if @tasting.save
        format.html { redirect_to @tasting, :notice => 'Tasting was successfully created.' }
        format.json { render :json => @tasting, :status => :created, :location => @tasting }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tasting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tastings/1
  # PUT /tastings/1.json
  def update
    @tasting = Tasting.find(params[:id])

    respond_to do |format|
      if @tasting.update_attributes(params[:tasting])
        format.html { redirect_to @tasting, :notice => 'Tasting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tasting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tastings/1
  # DELETE /tastings/1.json
  def destroy
    @tasting = Tasting.find(params[:id])
    @tasting.destroy

    respond_to do |format|
      format.html { redirect_to tastings_url }
      format.json { head :no_content }
    end
  end
end

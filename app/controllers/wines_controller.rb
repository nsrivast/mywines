class WinesController < ApplicationController
  # -- mobile device methods (from scottwb.com)
  before_filter :check_for_mobile
  
  # require 'zxing'
  # ZXing.decode '/Users/ecin/qrcode.png' #=> "QRcode string"
  
  # GET /wines
  # GET /wines.json
  def index
    @wines = Wine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @wines }
    end
  end

  # GET /wines/1
  # GET /wines/1.json
  def show
    @wine = Wine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @wine }
    end
  end

  # GET /wines/new
  # GET /wines/new.json
  def new
    @wine = Wine.new
    
    @vineyards_js = csv_array(Vineyard.where('name != ""').map{ |v| v.name },'"',",")
    @subregions_js = csv_array(Subregion.where('name != ""').map{ |v| v.name },'"',",")
    @regions_js = csv_array(Region.where('name != ""').map{ |v| v.name },'"',",")
    @countries_js = csv_array(Country.where('name != ""').map{ |v| v.name },'"',",")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @wine }
    end
  end
  
  def csv_array(myarr,appendage,delim)
    return '[' + myarr.map { |e| appendage + e + appendage }.join(delim) + ']'
  end

  # GET /wines/1/edit
  def edit
    @wine = Wine.find(params[:id])
    @heritage = @wine.get_heritage()
    
    @vineyards_js = csv_array(Vineyard.where('name != ""').map{ |v| v.name },'"',",")
    @subregions_js = csv_array(Subregion.where('name != ""').map{ |v| v.name },'"',",")
    @regions_js = csv_array(Region.where('name != ""').map{ |v| v.name },'"',",")
    @countries_js = csv_array(Country.where('name != ""').map{ |v| v.name },'"',",")
  end

  # POST /wines
  # POST /wines.json
  def create
    @wine = Wine.new(params[:wine].reject{ |k, v| ['vineyard', 'subregion', 'region', 'country'].include?(k) })
    Country.add_tuple(params[:wine][:vineyard], params[:wine][:subregion], params[:wine][:region], params[:wine][:country])
    v = Vineyard.find_by_name(params[:wine][:vineyard])
    @wine.vineyard_id = v.id

    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, :notice => 'Wine was successfully created.' }
        format.json { render :json => @wine, :status => :created, :location => @wine }
      else
        format.html { render :action => "new" }
        format.json { render :json => @wine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wines/1
  # PUT /wines/1.json
  def update
    @wine = Wine.find(params[:id])

    respond_to do |format|
      if @wine.update_attributes(params[:wine])
        format.html { redirect_to @wine, :notice => 'Wine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @wine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1
  # DELETE /wines/1.json
  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy

    respond_to do |format|
      format.html { redirect_to wines_url }
      format.json { head :no_content }
    end
  end
  
  # =================
  # guesser logic
  # =================

  # guesses vintage, displays tables to select of varietal and classification
  # (renders a javascript partial)
  def guesser
    @input_name = params[:input_name]
    unless @input_name == ""      
      @vintage = /[0-9]{4,4}/.match(@input_name)

      sorted_keywords = oneAndTwoWordStrings(params[:input_name]).sort
      @varietals = findVarietals(sorted_keywords) if sorted_keywords.length > 0
      @classifications = findClassifications(sorted_keywords) if sorted_keywords.length > 0
    end
    
    respond_to do |format|
      format.html{ render :layout => false }
      format.js{ render :layout => false }
    end
  end
  
  # matches varietal(s) from list
  def findVarietals(keywords)
    varietals = ["Aglianico", "Albarino", "Ansonica", "Arinto", "Arneis", "Barbera", "Cabernet Franc", "Cabernet Sauvignon", "Cannonau", "Carignane", "Carinena", "Carmenere", "Catawba", "Chardonnay", "Chasellas", "Chenin Blanc", "Cinsaut", "Cortese", "Corvina", "Counoise", "Dolcetto", "Ehrenfelser", "Fiano", "Folle Blanc", "Freisa", "Furmint", "Gamay", "Gewurztraminer", "Grechetto", "Grenache", "Kerner", "Lagrein", "Macebeo", "Malbec", "Malvasia", "Marsanne", "Mazuela", "Melon", "Merlot", "Montepulciano", "Moscato", "Mourvedre", "Muller-Thurgau", "Muscadet", "Muscat", "Nebbiolo", "Negroamaro", "Palomino", "Parellada", "Pedro Ximenez", "Petite Cabernet", "Petite Verdot", "Petite Vidure", "Petite Vidure", "Pinot Bianco", "Pinot Blanc", "Pinot Grigio", "Pinot Gris", "Pinot Meunier", "Pinot Noir", "Primitivo", "Prugnolo", "Rousanne", "Sangiovese", "Sauvignon Blanc", "Savagnin", "Scheurebe", "Schiava", "Semillion", "Seyval Blanc", "Sylvaner", "Syrah", "Temperanillo", "Traminer", "Trebbiano", "Ugni Blanc", "Verdiccio", "Vernaccia", "Viognier", "Viura", "Welschriesling", "Zinfandel"];
    return sortedArrayIntersection(varietals, keywords)
  end

  # returns tuples of form ["vineyard", "subregion", "region", "country"]
  # where any classification matches a keyword in input
  def findClassifications(keywords)
    sql_string = (["name LIKE ?"]*(keywords.length)).join(" OR ")
    sql_query = [sql_string] + keywords.collect { |k| "%#{k}%"}
    
    vineyards = Vineyard.find(:all, :conditions => sql_query)
    subregions = Subregion.find(:all, :conditions => sql_query)
    regions = Region.find(:all, :conditions => sql_query)
    countries = Country.find(:all, :conditions => sql_query)

    # { my_id => [my_name, my_other_id], ... }
    v_lookup = Hash[Vineyard.all.collect { |v| [f_attr(v, "id"), [f_attr(v, "name"), f_attr(v, "subregion_id")]] } ]
    s_lookup = Hash[Subregion.all.collect { |v| [f_attr(v, "id"), [f_attr(v, "name"), f_attr(v, "region_id")]] } ]
    r_lookup = Hash[Region.all.collect { |v| [f_attr(v, "id"), [f_attr(v, "name"), f_attr(v, "country_id")]] } ]
    c_lookup = Hash[Country.all.collect { |v| [f_attr(v, "id"), [f_attr(v, "name")]] } ]
    
    tuples = []
    [vineyards, subregions, regions, countries].flatten.each do |elem|
      v = v_lookup[elem.id] if elem.class == Vineyard
      s = s_lookup[elem.id] if elem.class == Subregion
      r = r_lookup[elem.id] if elem.class == Region
      c = c_lookup[elem.id] if elem.class == Country
      
      v ||= [""]
      s ||= (v != [""] ? s_lookup[v[1]] : [""])
      r ||= (s != [""] ? r_lookup[s[1]] : [""])
      c ||= (r ? c_lookup[r[1]] : [""])
      
      tuples.append([v[0], s[0], r[0], c[0]])
    end

  	return tuples
  end
  
  def f_attr(x, attr_name)
    return x[attr_name]
  end
  
  # return consecutive 1- and 2-word combinations in input string
  # min_word_length 
  def oneAndTwoWordStrings(str)
    min_word_length = 3
  	keywords = str.split(' ').reject{ |word| word.length < min_word_length }
    
  	n = keywords.length  
  	newwords = (0..(n-2)).collect { |i| keywords[i] + " " + keywords[i+1] }
  	return (keywords + newwords)
  end
  
  # return intersecting values of two sorted arrays. 
  # converts both to lower case (returns original of first array).
  def sortedArrayIntersection(arr1, arr2) 
  	i1 = 0
  	i2 = 0
  	intersection = []
    
  	while (i1 < arr1.length && i2 < arr2.length)
  		item1 = arr1[i1].downcase
  		item2 = arr2[i2].downcase
  		i1 = i1 + 1 if (item1 < item2)
      i2 = i2 + 1 if (item1 > item2)
      if item1 == item2
  			intersection.push(arr1[i1])
  			i1 = i1 + 1
        i2 = i2 + 1
  		end
  	end
    
  	return intersection
  end
    
end

class ClassificationController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  # -- mobile device methods (from scottwb.com)
  before_filter :check_for_mobile
  
  def index
    @full_list = full_classification_list()
  end
  
  def show
    @obj = params[:type].classify.constantize.find(params[:id])
    
    hierarchy = ['Vineyard', 'Subregion', 'Region', 'Country']
    loc = hierarchy.index(@obj.class.to_s)
    
    @children = @obj.send(hierarchy[loc-1].downcase.pluralize) if loc > 0
    @parent = @obj.send(hierarchy[loc+1].downcase) if loc < hierarchy.length - 1
    
    @wines = @obj.wines
  end
  
  
  def add_classification
    c = Country.add_tuple(params[:v], params[:s], params[:r], params[:c])
    
    redirect_to '/classification/index', :notice => "Classification was successfully created."
  end

  def add_classification_bulk
    lines = params[:input].split(/\r\n?/)
    n_err = 0
    n_ok = 0
    lines.each do |l|      
      if (l.count ",") == 3
        vsrc = l.split(",")
        c = Country.add_tuple(vsrc[0], vsrc[1], vsrc[2], vsrc[3])
        n_ok = n_ok + 1
      else
        n_err = n_err + 1
      end
    end
    msg = "#{pluralize(n_ok, 'classification')} successfully created. " + "#{pluralize(n_err, 'classification')} incorrectly formatted."
    redirect_to '/classification/index', :notice => msg
  end
  
  # returns list of lists of [v_id, "v_name", s_id "s_name", r_id, "r_name", c_id, "c_name"] 
  # for each unique entry in database where name != ""
  def full_classification_list
    
    vs = Hash[Vineyard.all.map { |v| [v.id, {:name => v.name, :up_id => v.subregion_id}] }]
    ss = Hash[Subregion.all.map { |s| [s.id, {:name => s.name, :up_id => s.region_id}] }]
    rs = Hash[Region.all.map { |r| [r.id, {:name => r.name, :up_id => r.country_id}] }]
    cs = Hash[Country.all.map { |c| [c.id, {:name => c.name, :up_id => nil}] }]

    full_list = []
    
    vs.reject { |k,v| v[:name].nil? || v[:name] == "" }.each do |k, v|
      s = ss[v[:up_id]]
      r = rs[s[:up_id]]
      c = cs[r[:up_id]]
      full_list = full_list.append([k, v[:name], v[:up_id], s[:name], s[:up_id], r[:name], r[:up_id], c[:name]])
    end
    
    ss.reject { |k,s| s[:name].nil? || s[:name] == "" }.each do |k, s|
      r = rs[s[:up_id]]
      c = cs[r[:up_id]]
      full_list = full_list.append([nil, nil, k, s[:name], s[:up_id], r[:name], r[:up_id], c[:name]])
    end
    
    rs.reject { |k,r| r[:name].nil? || r[:name] == "" }.each do |k, r|
      c = cs[r[:up_id]]
      full_list = full_list.append([nil, nil, nil, nil, k, r[:name], r[:up_id], c[:name]])
    end
      
    cs.reject { |k,c| c[:name].nil? || c[:name] == "" }.each do |k, c|
      full_list = full_list.append([nil, nil, nil, nil, nil, nil, k, c[:name]])
    end

    return full_list
  end
  
end

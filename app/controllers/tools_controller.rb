class ToolsController < ApplicationController

  helper :application
  include ApplicationHelper
  
  def tool
    # Default values 
    direction = "desc"
    order = "id"
    
    # Choose order by 
    # @todo use switch! 
    if params[:order] == "error_type"
        order = "error_type"
    end
    if params[:order] == "loc_file"
        order = "loc_file"
    end
    if params[:order] == "id"
        order = "id"
    end
    if params[:order] == "marking"
        order = "marking"
    end
    
    # Choose direction of order
    # @todo use switch! 
    if params[:direction] == "desc"
      direction = "desc"
    end
    if params[:direction] == "asc"
      direction = "asc"
    end
    
    
    
    
    # Prepare new links direction
    error_type = (params[:order]=='error_type')?((params[:direction]=='desc')?'asc':'desc'):'desc'
    loc_file = (params[:order]=='loc_file')?((params[:direction]=='desc')?'asc':'desc'):'desc'
    id_dir = (params[:order]=='id')?((params[:direction]=='desc')?'asc':'desc'):'desc'
    marking_dir = (order=='marking')?((direction=='desc')?'asc':'desc'):'desc'
    
    @links_direction = {
      'error_type' => error_type,
      'loc_file' => loc_file,
      'id' => id_dir,
      'marking' => marking_dir
    }
    @ordering_method = "tool"
    
    
    @tool = Tool.find(params[:id])
    if params[:marking] != nil && params[:marking] != ""
      @marking = params[:marking]
      @params = "/"+params[:id]+"/"+params[:marking]
      @errors = @tool.errors.where(:marking => params[:marking]).order(order+" "+direction)
    else
      @marking = nil
      @params = "/"+params[:id]
      @errors = @tool.errors.order(order+" "+direction)
    end
   
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  
  def index 
     @tools = Tool.all()
     
     respond_to do |format|
       format.html # index.html.erb
     end
  end
  
end

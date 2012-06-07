class ErrorsController < ApplicationController
  # GET /errors
  # GET /errors.json
  helper :application
  include ApplicationHelper
  
  def index
    @errors = Error.includes(:user, :error_type).order("timestamp_enter DESC")
    @ordering_method = "order"
    @params = ""
    
    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @errors }
    end
  end

  # GET /errors/1
  # GET /errors/1.json
  #
  # Show one error details.
  #
  def show
    @error = Error.find(params[:id])
    
    require 'rubygems'
    require 'zip/zip'
    require 'coderay'
    source = ""
    
    file = helperGetFile(@error.loc_file_hash)
    file_out = ""
    line_number = 0
    plus_minus_lines = 20
    
    file.each_line do |line| 
       if line_number >= @error.loc_line - plus_minus_lines && line_number <= @error.loc_line + plus_minus_lines
          file_out += line
       end
       line_number += 1
    end 
    
    if  file_out != "" 
      source = CodeRay.highlight(file_out, :c, {:line_numbers => :inline, :css => :class, :line_number_start => @error.loc_line - plus_minus_lines+1})
    end
    
    line_number = 0 #because of div wrapper 
    
    source_out = ""
    source.each_line do |line| 
          if line_number == plus_minus_lines
              source_out += "<div class=\"error_line_highlight\">"+line+"</div>"
          else
              source_out += line
          end
          line_number += 1
    end 
    
    
    if(source_out == "")
      @source_output = ""
    else
      @source_output = source_out.html_safe
    end
    @method = "order"
    @params = "a"
    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @error }
    end
  end
  
  def source_code
    @error = Error.find(params[:id])
    
    require 'rubygems'
    require 'zip/zip'
    require 'coderay'
    source = ""
    
    highlighted_file = helperGetHighlightedFile(@error.loc_file_hash)
    
    if  highlighted_file == "" 
      file = helperGetFile(@error.loc_file_hash)
      if file != ""
        source = CodeRay.highlight(file, :c, {:line_numbers => :inline, :css => :class})
      end
    else 
      source = highlighted_file
    end
    
    line_number = 0 #because of div wrapper 
    source_out = ""
    
    source.each_line do |line| 
          if line_number == @error.loc_line
             source_out << "<div class=\"error_line_highlight\">"
	     source_out << line
	     source_out << "</div>"
          else
             source_out << line
          end
          line_number += 1
    end 
    
    
#    if(source_out == "")
#      @source_output = ""
#    else
#      @source_output = source_out
#    end
    @source_output = source_out.html_safe
    
    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @error }
    end
  end

  # GET ERROR DETAILS TABLE BY AJAX
  def error_details
    @error = Error.find(params[:id])
    render :template => 'shared/_error_details_ajax',:layout => false
  end
  
  
  def error_details_source
    @error = Error.find(params[:id])
    require 'rubygems'
    require 'zip/zip'
    require 'coderay'
    source = ""

    
    highlighted_file = helperGetHighlightedFile(@error.loc_file_hash)
    source = ""
    
    if  highlighted_file == "" 
      file = helperGetFile(@error.loc_file_hash)
      if file != ""
        source = CodeRay.highlight(file, :c, {:line_numbers => :inline, :css => :class})
      end
    else 
      source = highlighted_file
    end
    
    #line_number = 0 #because of div wrapper 
    #source_out = source
    
    
     #source.each_line do |line| 
      #   if line_number == @error.loc_line
      #       source_out += "<div class=\"error_line_highlight\">"+line+"</div>"
      #    else
      #        source_out += line
      #    end
      #   line_number += 1
    #end
   
    @source_output = source.html_safe #source_out
    
    if source != "" 
        render :template => 'shared/_error_details_source_ajax',:layout => false
    else 
        render :nothing => true
    end
    
  end
  
  
  # GET /errors/order/BY/DIRECTION
  #
  # Show errors ordered by selected column and direction.
  #
  def order
    
    
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
    
    # get ordered errors from DB
    @errors = Error.includes(:user, :error_type, :project).order(order +" "+ direction)

    # Prepare new links directions
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
    @params = "order"
    respond_to do |format|
      format.html # order.html.erb
      #format.json { render json: @errors }
      #format.json { render json: @links_direction }
    end
  end
  

end

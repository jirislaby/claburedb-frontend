class TypeController < ApplicationController

  helper :application
  include ApplicationHelper

  def index
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

    # Choose direction of order
    # @todo use switch!
    if params[:direction] == "desc"
      direction = "desc"
    end
    if params[:direction] == "asc"
      direction = "asc"
    end
    if params[:order] == "marking"
        order = "marking"
    end

    @ordering_method = ""

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

    @type = ErrorType.find(params[:id])
    if params[:marking] != nil && params[:marking] != ""
      @errors = Error.includes(:user, :error_type).where(:error_type => params[:id], :marking => params[:marking]).order(order+" "+direction)
      @params = ""+params[:id]+"/"+params[:marking]
    else
      @errors = Error.includes(:user, :error_type).where(:error_type => params[:id]).order(order+" "+direction)
      @params = ""+params[:id]
    end

    respond_to do |format|
      format.html # index.html.erb
    end

  end

  def all
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


    @ordering_method = ""

    # Prepare new links direction
    error_type = (order=='error_type')?((direction=='desc')?'asc':'desc'):'desc'
    loc_file = (order=='loc_file')?((direction=='desc')?'asc':'desc'):'desc'
    id_dir = (order=='id')?((direction=='desc')?'asc':'desc'):'desc'
    marking_dir = (order=='marking')?((direction=='desc')?'asc':'desc'):'desc'

    @links_direction = {
      'error_type' => error_type,
      'loc_file' => loc_file,
      'id' => id_dir,
      'marking' => marking_dir
    }


    if params[:marking] != nil && params[:marking] != ""
      @errors = Error.includes(:user, :error_type).where(:marking => params[:marking]).order(order+" "+direction)
      @params = "all/"+params[:marking]
    else
      @errors = Error.includes(:user, :error_type).order(order+" "+direction)
      @params = "all"
    end

    respond_to do |format|
      format.html # index.html.erb
    end

  end


end

class ProjectController < ApplicationController

  helper :application
  include ApplicationHelper

  def project


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
    if params[:order] == "marking"
        order = "marking"
    end

    @project = Project.find(params[:id])
    @ordering_method = "project"
    @params = ""

    if params[:marking] != nil && params[:marking] != ""
      @errors = Error.includes(:user, :error_type).order(order+" "+direction).where(:project => params[:id], :marking => params[:marking])
      @params = "/"+params[:id]+"/"+params[:marking]
    else
      @errors = Error.includes(:user, :error_type).order(order+" "+direction).where(:project => params[:id])
      @params = "/"+params[:id]
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


    respond_to do |format|
      format.html # index.html.erb
    end

  end

  # GET /errors/order/BY/DIRECTION
  #
  # Show errors ordered by selected column and direction.
  #
  def order




    # get ordered errors from DB
    @errors = Error.includes(:user, :error_type, :project).order(order +" "+ direction)



    respond_to do |format|
      format.html # order.html.erb
      #format.json { render json: @errors }
      #format.json { render json: @links_direction }
    end
  end

  def version
    @project = Project.find(params[:id])
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


    @project = Project.find(params[:id])
    @ordering_method = "version"
    @params = "/"+params[:id]+"/"+params[:version]
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

    @errors = Error.includes(:user, :error_type).order(order+" "+direction).where(:project => params[:id], :project_version => params[:version])

    respond_to do |format|
      format.html # version.html.erb
    end
  end

  def index
     @projects = Project.find(
       :all,
       :select => '*, (SELECT count(*) FROM "error" WHERE error.project = project.id) overall_count,
       (SELECT count(*) FROM "error" WHERE error.project = project.id AND marking >= 1) real_count,
       (SELECT count(*) FROM "error" WHERE error.project = project.id AND marking = 0) unclass_count,
       (SELECT count(*) FROM "error" WHERE error.project = project.id AND marking <= -1) false_count',
       :order => "name ASC"
     )
     respond_to do |format|
       format.html # overview.html.erb
     end
  end

end

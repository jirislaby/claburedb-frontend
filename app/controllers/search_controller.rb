class SearchController < ApplicationController
  # GET /errors
  # GET /errors.json
  helper :application
  include ApplicationHelper
  
  def index
     if params[:search]!=nil && params[:search]!="" 
        @errors = Error.find_by_sql("SELECT * FROM error
                                  WHERE loc_file LIKE '%"+params[:search]+"%'")
     end
     
     respond_to do |format|
        format.html # index.html.erb
     end
  end

end

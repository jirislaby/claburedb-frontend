class SearchController < ApplicationController
  # GET /errors
  # GET /errors.json
  helper :application
  include ApplicationHelper
  
  def index
     @errors = Error.find_by_sql("SELECT * FROM error
                                  WHERE loc_file LIKE '%"+params[:search]+"%'")
   
     respond_to do |format|
        format.html # index.html.erb
     end
  end

end

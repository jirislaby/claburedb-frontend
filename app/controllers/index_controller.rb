class IndexController < ApplicationController

  helper :application
  include ApplicationHelper
  
  def index
    #@types = Error_type.select('*','count(Errors.').order("short_description ASC")
    @types = ErrorType.find(
     :all, 
     :select => '*, (SELECT count(*) FROM "error" WHERE error.error_type = error_type.id) overall_count,
     (SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking >= 1) real_count,
     (SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking = 0) unclass_count,
     (SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking <= -1) false_count', 
     :order => "name ASC"
     )
    
    #"select count(*) FROM "error" WHERE error.error_type = error_type.id AND "marking" > 1" real_count,
                  #  "select count(*) FROM "error" WHERE error.error_type = error_type.id AND "marking" = 0" unclass_count,
                  #  "select count(*) FROM "error" WHERE error.error_type = error_type.id AND "marking" < 1" false_count
                   
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end

  
  

end

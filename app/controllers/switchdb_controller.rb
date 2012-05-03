class SwitchdbController < ApplicationController

  helper :application
  include ApplicationHelper
  require 'yaml'
  
  def index
    dbs = YAML::load(File.open("#{Rails.root}/config/databases.yml"))
      
    if params[:db_id] != nil || params[:db_id] !=""
      dbs["databases"].each do |db|
        if db["id"] == params[:db_id]
          session[:db_id] = db["id"]
        end
      end
    else
      dbs["databases"].each do |db|
        if db["default"] 
          session[:db_id] = db["id"]
        end
      end
    end
    
    
    redirect_to root_url
    
  end

  
  

end

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :select_db
  helper :all
  require 'yaml'
  
  private

    def select_db

      if session[:db_id] == nil || session[:db_id] == ""
        default_db
      else
        other_db(session[:db_id])
      end
    end

    def default_db
      dbs = YAML::load(File.open("#{Rails.root}/config/databases.yml"))
      
      dbs["databases"].each do |db|
        if db["default"] 
          ActiveRecord::Base.establish_connection(
            :adapter => 'sqlite3',
            :database => db["file"]
          )
        end
      end
    end

    def other_db(db_id)
      dbs = YAML::load(File.open("#{Rails.root}/config/databases.yml"))
      
      dbs["databases"].each do |db|
        if db["id"] == db_id
          ActiveRecord::Base.establish_connection(
            :adapter => 'sqlite3',
            :database => db["file"]
          )
        end
      end
      

    end

end

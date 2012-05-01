class FilesController < ApplicationController
  
  def show
      require 'zip/zip'
      require 'zip/zipfilesystem'
      
      sha_path = "#{Rails.root}"+"/"+APP_CONFIG["sha1_path"]
      zip_file_path = ""+sha_path+params[:sha1][0..1]+"/"+params[:sha1]+".zip"
      puts zip_file_path
      file = "";
      Zip::ZipFile.open(zip_file_path) { |zip_file|
          zip_file.each { |f|
              file = zip_file.read(f)
         }
      }
      
      # make hash 
      @file_content = file
      
    
      respond_to do |format|
        format.html # show.html.erb
        #format.json { render json: @file_content }
      end
      
      puts file;
  end

  def savefile
  end

end

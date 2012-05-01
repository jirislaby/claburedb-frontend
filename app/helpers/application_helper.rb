module ApplicationHelper
  def helperGetFile(hash)
      require 'zip/zip'
      require 'zip/zipfilesystem'
      file = ""
      
      if hash != nil
        sha_path = "#{Rails.root}"+"/"+Rails.application.config.sha1_path
        zip_file_path = sha_path+hash[0..1]+"/"+hash+".zip"
        zip_file_path
        if File.exists?(zip_file_path)
          Zip::ZipFile.open(zip_file_path) { |zip_file|
              zip_file.each { |f|
                  file = zip_file.read(f)
             }
          }
        end
      end
      
      #Return file string:
      ""+file
  end
  
  def helperGetErrorSurroundings(hash)
    require 'zip/zip'
      require 'zip/zipfilesystem'
      file = "";
      
      if hash != nil
        sha_path = "#{Rails.root}"+"/"+Rails.application.config.sha1_path
        zip_file_path = sha_path+hash[0..1]+"/"+hash+".zip"
        zip_file_path
        if File.exists?(zip_file_path)
          Zip::ZipFile.open(zip_file_path) { |zip_file|
              zip_file.each { |f|
                  file = zip_file.read(f)
             }
          }
        end
      end
      
      
      file_out = ""
      line_number = 0
      plus_minus_lines = 20
      
      file.each_line do |line| 
         if line_number >= @error.loc_line - plus_minus_lines && line_number <= @error.loc_line + plus_minus_lines
            file_out += line
         end
         if line_number > @error.loc_line + plus_minus_lines
            break
         end
         line_number += 1
     end
     ""+file_out
  end
end

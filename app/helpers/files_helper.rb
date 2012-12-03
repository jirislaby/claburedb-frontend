module FilesHelper
  def helperGetFile(hash)
      require 'zip/zip'
      require 'zip/zipfilesystem'

      sha_path = "#{Rails.root}"+"/"+Rails.application.config.sha1_path
      zip_file_path = sha_path+hash[0..1]+"/"+hash+".zip"
      puts zip_file_path
      file = "";
      Zip::ZipFile.open(zip_file_path) { |zip_file|
          zip_file.each { |f|
              file = zip_file.read(f)
         }
      }

      ""+file;
  end
end

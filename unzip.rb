    require 'rubygems'
    require 'zip/zip'
    require 'digest/sha1'
    require 'fileutils'
    require 'zlib'
    require 'archive/tar/minitar'
    include Archive::Tar




    temp_directory = "tmp/upload/"
    files_path = "tmp/sha1/"

    # CREATE TEMP DIRECTORY IF IT DOESNT EXIST
    if !File.exists?(temp_directory) || !File.directory?(temp_directory)
            Dir.mkdir(temp_directory)
    end

    # CREATE SHA1 DIRECTORY IF IT DOESNT EXIST
    if !File.exists?(files_path) || !File.directory?(files_path)
            Dir.mkdir(files_path)
    end

    # Iterate through all arguments
    ARGV.each do|a|
       next if #{a} == nil || #{a} == ""


      # tar.gz, .tgz, .tar OR .zip FILE
      puts #{a}
      zip_file_path = "tmp/#{a}"

      puts zip_file_path


      # GET EXTENSION
      ext = File.extname(zip_file_path)
      puts ext

      # IF TAR FILE, USE MINITAR LIBRARY
      if ext == ".gz" || ext == ".tgz" || ext == ".tar"
        tgz = Zlib::GzipReader.new(filesFile = File.open(zip_file_path, 'rb'))
        Minitar.unpack(tgz, temp_directory)
      else
        # IF ZIP FILE, USE RubyZip
        # UNZIP ALL FILES TO TEMP DIRECTORY
        Zip::ZipFile.open(zip_file_path) { |zip_file|
            zip_file.each { |f|
                f_path=File.join(temp_directory, f.name)
                FileUtils.mkdir_p(File.dirname(f_path))
                zip_file.extract(f, f_path) unless File.exist?(f_path)
           }
        }
      end



    #End of Arguments iteration
    end

    # ITERATE ALL FILES IN TEMP DIRECTORY
    Dir[File.join(temp_directory, "**/*.*")].each do |filename|
          # CONTINUE IF FILE IS DIRECTORY
          next if File.directory? filename

          # OPEN FILE
          file = File.open(filename)

          # READ FILE AND MAKE SHA1 HASH
          content = file.read
          sha1 = Digest::SHA1.hexdigest(content)
          new_path = files_path+sha1[0..1]

          # IF DIR DOESNT EXISTS MAKE IT
          if !File.exists?(new_path) || !File.directory?(new_path)
            Dir.mkdir(new_path)
          end

          # ADD FILE TO ZIP
          Zip::ZipFile.open(new_path+"/"+sha1+".zip", Zip::ZipFile::CREATE) {
            |zipfile|
            zipfile.get_output_stream(File.basename(filename)) { |f| f.puts content }
          }
    end

    # DELETE TEMP FOLDER
    FileUtils.rm_rf temp_directory





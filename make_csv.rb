    require 'rubygems'
    require 'zip/zip'
    require 'digest/sha1'
    require 'fileutils'

    zip_file_path = "tmp/files.zip"
    temp_directory = "tmp/upload/"
    files_path = "tmp/sha1/"
    csv_file = "tmp/hashes.csv"

    csv = File.open(csv_file,"w+")

    Dir.chdir(temp_directory+"/linux-2.6.28/linux-2.6.28/")
    # ITERATE ALL FILES IN TEMP DIRECTORY
    Dir[File.join(Dir.pwd, "**/*.*")].each do |filename|
        # CONTINUE IF FILE IS DIRECTORY
        next if File.directory? filename

        # OPEN FILE
        file = File.open(filename)

        # READ FILE AND MAKE SHA1 HASH
        content = file.read
        sha1 = Digest::SHA1.hexdigest(content)

        csv.puts(filename + ";"+sha1)
    end






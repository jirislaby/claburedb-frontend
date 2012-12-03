module ApplicationHelper
	def condLink(cnt, link)
		if cnt > 0
			link_to(cnt, link)
		else
			cnt.to_s
		end
	end

	def get_dir_order
		@links_direction = {
			'error_type' => 'asc',
			'loc_file' => 'asc',
			'id' => 'asc',
			'marking' => 'asc'
		}

		if params[:order_dir] == 'desc'
			dir = 'desc'
			other_dir = 'asc'
		else
			dir = 'asc'
			other_dir = 'desc'
		end

		case params[:order]
		when 'loc_file', 'marking'
			order_val = order = params[:order]
		when 'error_type'
			order_val = params[:order]
			order = 'error_type.name'
		else
			order_val = order = 'id'
		end

		@links_direction[order_val] = other_dir
		order + " " + dir
	end

	def handle_marking(errors)
		marking = params[:marking]
		if marking != nil && marking != ""
			errors = errors.where(:marking => params[:marking])
			@query = { :marking => params[:marking] }
		end
		errors
	end

  def helperGetFile(hash)
      require 'zip/zip'
      require 'zip/zipfilesystem'
      file = ""

      if hash != nil
        sha_path = "#{Rails.root}"+"/"+Rails.application.config.sha1_path
        zip_file_path = sha_path+hash[0..1]+"/"+hash+".zip"
        #zip_file_path
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

  def helperGetHighlightedFile(hash)
      require 'zip/zip'
      require 'zip/zipfilesystem'
      file = ""

      if hash != nil
        sha_path = "#{Rails.root}"+"/"+Rails.application.config.sha1_path
        zip_file_path = sha_path+hash[0..1]+"/"+hash+"-hl.zip"
        #zip_file_path
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

end

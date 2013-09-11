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
		when 'marking'
			order_val = order = params[:order]
		when 'loc_file'
			order_val = params[:order]
			order = 'loc_file, loc_line'
		when 'error_type'
			order_val = params[:order]
			order = 'error_type.name'
		else
			order_val = 'id'
			order = 'error.id'
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

	def helperGetFileXZ(file)
		require 'xz'

		XZ.decompress_stream(File.open(file, "rb"))
	end

	def highlight(code)
		CodeRay.scan(code, :c).html(:css => :class,
				:break_lines => true, :line_numbers => :inline)
	end

	def finalize(code)
		code = '<div class="CodeRay"><div class="code"><pre>' << code <<
				'</pre></div></div>'
		code.html_safe
	end

	def helperGetHighlightedFile(hash, params = {})
		require 'coderay'

		if !(hash =~ /^[0-9a-f]{40}$/)
			raise "invalid hash"
		end

		base_name = files_dir() + hash[0..1] + "/" + hash

		if File.exists?(base_name + "-hl.xz")
			data = helperGetFileXZ(base_name + "-hl.xz")
		elsif File.exists?(base_name + ".xz")
			data = highlight(helperGetFileXZ(base_name + ".xz"))
		else
			return nil
		end

		hl = params[:highlight]
		crop_top = params[:crop_top]
		crop_bot = params[:crop_bot]

		if !hl
			return finalize(data)
		end

		out = ""
		line_number = 1
		data.each_line { |line|
			if (crop_bot && line_number > hl + crop_bot)
				break
			end
			if (!crop_top || hl - crop_top <= line_number)
				if hl == line_number
					out << '<span class="error_line_highlight">' <<
						line << "</span>"
				else
					out << line
				end
			end
			line_number += 1
		}

		finalize(out)
	end

end

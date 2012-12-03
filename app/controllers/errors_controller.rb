class ErrorsController < ApplicationController

	helper :application
	include ApplicationHelper

	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

	def index
		dir_order = get_dir_order()

		@errors = handle_marking(Error.includes(:user, :error_type).
				order(dir_order))

		respond_to do |format|
			format.html # index.html.erb
		end
	end

	def show
		@error = Error.includes(:user, :error_type, :project_info).
			find(params[:id])
		@query = {}

		require 'rubygems'
		require 'zip/zip'
		require 'coderay'
		source = ""

		file = helperGetFile(@error.loc_file_hash)
		file_out = ""
		line_number = 0
		plus_minus_lines = 20
		full = params[:full] == 'yes'

		if full
			@query = { :full => 'yes' }
			file_out = file
		else
			file.each_line do |line|
				if line_number >= @error.loc_line - plus_minus_lines - 1 && line_number < @error.loc_line + plus_minus_lines
					file_out << line
				end
				line_number += 1
			end
		end

		line_start = 1
		if !full
			if (plus_minus_lines > @error.loc_line)
				line_match = @error.loc_line
			else
				line_start = @error.loc_line -
					plus_minus_lines
				line_match = plus_minus_lines + 1
			end
		end

		if file_out != ""
			source = CodeRay.highlight(file_out, :c, {:line_numbers => :inline,
			      :css => :class, :line_number_start => line_start})
		end

		line_number = 0 #because of div wrapper

		source_out = ""
		source.each_line do |line|
		  if (full && line_number == @error.loc_line) ||
		  		(!full && line_number == line_match)
		  	source_out << "<span class=\"error_line_highlight\">" <<
				line << "</span>"
		  else
		      source_out << line
		  end
		  line_number += 1
		end

		if (source_out == "")
			@source_output = ""
		else
			@source_output = source_out.html_safe
		end

		respond_to do |format|
			format.html # show.html.erb
		end
	end

	# GET ERROR DETAILS TABLE BY AJAX
	def error_details
		@error = Error.includes(:user, :error_type, :project_info).
				find(params[:id])
		render :template => 'shared/_error_details_ajax',
			:layout => false
	end


  def error_details_source
    @error = Error.find(params[:id])
    require 'rubygems'
    require 'zip/zip'
    require 'coderay'
    source = ""

    highlighted_file = helperGetHighlightedFile(@error.loc_file_hash)
    source = ""

    if  highlighted_file == ""
      file = helperGetFile(@error.loc_file_hash)
      if file != ""
        source = CodeRay.highlight(file, :c, {:line_numbers => :inline, :css => :class})
      end
    else
      source = highlighted_file
    end

    #line_number = 0 #because of div wrapper
    #source_out = source

     #source.each_line do |line|
      #   if line_number == @error.loc_line
      #       source_out += "<div class=\"error_line_highlight\">"+line+"</div>"
      #    else
      #        source_out += line
      #    end
      #   line_number += 1
    #end

    @source_output = source.html_safe #source_out

    if source != ""
        render :template => 'shared/_error_details_source_ajax',:layout => false
    else
        render :nothing => true
    end

  end

end

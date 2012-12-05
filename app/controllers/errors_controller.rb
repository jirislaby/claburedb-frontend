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
		hl_parm = { :highlight => @error.loc_line }

		full = params[:full] == 'yes'
		if full
			@query = { :full => 'yes' }
		else
			hl_parm[:crop] = 20
		end

		@source_output = helperGetHighlightedFile(@error.loc_file_hash,
				hl_parm);

		respond_to do |format|
			format.html
		end
	end

	# === AJAX HANDLING BELOW ===

	def get_details
		@error = Error.includes(:user, :error_type, :project_info).
				find(params[:id])
		render :template => 'errors/ajax_get_details',
			:layout => false
	end

	def get_source
		@error = Error.find(params[:id])

		@source_output = helperGetHighlightedFile(@error.loc_file_hash,
				:highlight => @error.loc_line)

		if @source_output
			render :template => 'errors/ajax_get_source',
				:layout => false
		else
			render :nothing => true
		end
	end

end

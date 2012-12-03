class SearchController < ApplicationController

	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

	def index
		@errors = []
		if params[:search] != nil && params[:search] != ""
			dir_order = get_dir_order()

			@errors = Error.includes(:error_type).
				where("loc_file LIKE ?",
						'%' + params[:search] + '%').
				order(dir_order)
			@query = { :search => params[:search] }
		end

		respond_to do |format|
			format.html # index.html.erb
		end
	end
end

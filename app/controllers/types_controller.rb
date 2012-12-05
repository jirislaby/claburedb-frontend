class TypesController < ApplicationController

	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

	def show
		dir_order = get_dir_order()

		@type = ErrorType.find(params[:id])
		@errors = handle_marking(@type.errors.
				includes(:user, :error_type).
				order(dir_order))

		respond_to do |format|
			format.html # index.html.erb
		end

	end

end

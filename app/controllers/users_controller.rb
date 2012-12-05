class UsersController < ApplicationController

	helper :application
	include ApplicationHelper
	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

	def index
		@users = User.all

		respond_to do |format|
			format.html
		end
	end

	def show
		@user = User.find(params[:id])

		# Replace password characters with asterisks
		@user.password = "*****"

		dir_order = get_dir_order()

		@errors = handle_marking(@user.errors.includes(:error_type).
				limit(50).order(dir_order))

		respond_to do |format|
			format.html
		end
	end

end

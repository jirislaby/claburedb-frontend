class ToolsController < ApplicationController

	before_filter :select_db

	def select_db
		super(params[:project_id])
	end

	def index
		@tools = Tool.all()

		respond_to do |format|
			format.html # index.html.erb
		end
	end

	def show
		dir_order = get_dir_order

		@tool = Tool.find(params[:id])
		@errors = handle_marking(@tool.errs.includes(:error_type).
				order(dir_order))

		respond_to do |format|
			format.html # index.html.erb
		end
	end

end

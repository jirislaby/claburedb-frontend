class ProjectsController < ApplicationController

	before_filter :select_db, :except => [ :index ]

	def select_db
		super(params[:id])
	end

	def index
		@projects = [];
		Project.all.each do |db|
			ActiveRecord::Base.establish_connection(
					:adapter => 'sqlite3',
					:database => "db/" + db.file)
			found = ProjectInfo.select('*,
				(SELECT count(id) FROM "error" WHERE error.project = project_info.id) overall_count,
				(SELECT count(id) FROM "error" WHERE error.project = project_info.id AND marking >= 1) real_count,
				(SELECT count(id) FROM "error" WHERE error.project = project_info.id AND marking = 0) unclass_count,
				(SELECT count(id) FROM "error" WHERE error.project = project_info.id AND marking <= -1) false_count').order("name ASC")
			found.each do |entry|
				entry.db_idx = db.id
			end
			@projects.concat(found);
		end
		@projects = @projects.sort_by { |h| h["name"] }
		respond_to do |format|
			format.html # overview.html.erb
		end
	end

	def show
		@types = ErrorType.select('*,
			(SELECT count(*) FROM "error" WHERE error.error_type = error_type.id) overall_count,
			(SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking >= 1) real_count,
			(SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking = 0) unclass_count,
			(SELECT count(*) FROM "error" WHERE error.error_type = error_type.id AND marking <= -1) false_count').order("name ASC");

		respond_to do |format|
			format.html # index.html.erb
		end
	end

	def download
		db = Project.find(project_id())
		send_file(Rails.root.to_s + "/db/" + db.file)
	end
end

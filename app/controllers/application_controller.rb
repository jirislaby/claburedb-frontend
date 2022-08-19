class ApplicationController < ActionController::Base

	helper :application
	include ApplicationHelper
	protect_from_forgery
	before_action :connect
	attr_reader :project_id
	attr_reader :files_dir
	helper_method :project_id

	@project_id = nil
	@files_dir = nil

	def initialize
		super
		@files_dir = "#{Rails.root}/" +
				Rails.application.config.sha1_path
	end

	def connect
		Project.establish_connection(
			:adapter => 'sqlite3',
			:database => 'db/databases.db')
	end

	def select_db(prj_id)
		if prj_id == nil
			raise "invalid project id"
		end
		prj_id = prj_id.to_i(10)
		db = Project.find(prj_id)
		if db == nil
			raise "invalid database selected"
		end
		ActiveRecord::Base.establish_connection(
				:adapter => 'sqlite3',
				:database => "db/" + db.file)
		@project_id = prj_id
	end

end

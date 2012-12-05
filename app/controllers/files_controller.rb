class FilesController < ApplicationController

	helper :application
	include ApplicationHelper

	def index
		raise "not allowed"
		@files = []
		dir = Dir.new(files_dir())
		dir.each { |entry|
			if entry.start_with?('.')
				next
			end
			subdir = Dir.new(files_dir() + "/" + entry)
			subdir.each { |entry|
				if entry =~ /([0-9a-f]{40})-hl\.zip/
					@files.push($1)
				end
			}
		}
		respond_to do |format|
			format.html
		end
	end

	def show
		@file_content = helperGetHighlightedFile(params[:id])
		@file_content ||= '<div style="color: red;">Not found!</div>'.
				html_safe

		respond_to do |format|
			format.html
		end
	end

end

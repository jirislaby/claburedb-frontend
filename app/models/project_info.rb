class ProjectInfo < ActiveRecord::Base
	self.table_name = 'project_info'
	has_many :errors, :foreign_key => "project"
	@db_idx = 0
	def db_idx
		@db_idx
	end
	def db_idx=(idx)
		@db_idx = idx
	end

	def to_s
		inspect.to_s + ", db_idx=" + self.db_idx.to_s
	end
end

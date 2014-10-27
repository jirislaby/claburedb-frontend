class Tool < ActiveRecord::Base
	self.table_name = 'tool'
	has_many :error_tool_rel
	# :errors is a member of ActiveRecord::Base, we use errs and :class_name
	has_many :errs, :through => :error_tool_rel
end

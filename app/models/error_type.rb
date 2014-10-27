class ErrorType < ActiveRecord::Base
	self.table_name = 'error_type'
	# :errors is a member of ActiveRecord::Base, we use errs and :class_name
	has_many :errs, :foreign_key => "error_type", :class_name => "Error"
end

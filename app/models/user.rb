class User < ActiveRecord::Base
	self.table_name = 'user'
	# :errors is a member of ActiveRecord::Base, we use errs and :class_name
	has_many :errs, :foreign_key => "user", :class_name => "Error"
end

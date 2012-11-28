class ErrorType < ActiveRecord::Base
  self.table_name = 'error_type'
  has_many :errors, :foreign_key => "error_type"
end

class ErrorType < ActiveRecord::Base
  set_table_name 'error_type'
  has_many :errors, :foreign_key => "error_type"
end

class ErrorToolRel < ActiveRecord::Base
  self.table_name = 'error_tool_rel'
  belongs_to :err, :class_name => 'Error', :foreign_key => 'error_id'
  belongs_to :tool
end

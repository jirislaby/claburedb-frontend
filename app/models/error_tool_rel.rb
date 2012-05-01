class ErrorToolRel < ActiveRecord::Base
  set_table_name 'error_tool_rel'
  belongs_to :error
  belongs_to :tool
end

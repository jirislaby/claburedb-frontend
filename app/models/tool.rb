class Tool < ActiveRecord::Base
  set_table_name 'tool'
  has_many :error_tool_rel
  has_many :errors, :through => :error_tool_rel, :foreign_key => "tool_id"
end

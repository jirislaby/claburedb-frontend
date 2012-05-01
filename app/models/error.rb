class Error < ActiveRecord::Base
  set_table_name 'error'
  belongs_to :user, :foreign_key => "user"
  belongs_to :error_type, :foreign_key => "error_type"
  belongs_to :project, :foreign_key => "project"
  has_many :error_tool_rel
  has_many :tools, :through => :error_tool_rel, :foreign_key => "error_id"
end

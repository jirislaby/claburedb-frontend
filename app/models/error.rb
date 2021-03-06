class Error < ActiveRecord::Base
  self.table_name = 'error'
  self.primary_key = 'id'
  belongs_to :user, :foreign_key => "user"
  belongs_to :error_type, :foreign_key => "error_type"
  belongs_to :project_info, :foreign_key => "project"
  has_many :error_tool_rel
  has_many :tools, :through => :error_tool_rel
end

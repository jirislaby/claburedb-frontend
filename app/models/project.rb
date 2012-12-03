class Project < ActiveRecord::Base
  self.table_name = 'project'
  has_many :errors, :foreign_key => "project"
end

class Project < ActiveRecord::Base
  set_table_name 'project'
  has_many :errors, :foreign_key => "project"
end

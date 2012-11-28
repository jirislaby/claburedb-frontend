class User < ActiveRecord::Base
  self.table_name = 'user'
  has_many :errors, :foreign_key => "user"
end

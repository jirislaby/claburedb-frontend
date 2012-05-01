class User < ActiveRecord::Base
  set_table_name 'user'
  has_many :errors, :foreign_key => "user"
end

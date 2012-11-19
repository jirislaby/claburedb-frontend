# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111014122059) do

  create_table "error_full", :force => true do |t|
    t.integer  "user",                             :null => false
    t.integer  "error_type",                       :null => false
    t.string   "error_subtype",     :limit => nil
    t.integer  "project",                          :null => false
    t.string   "project_version",   :limit => 32
    t.string   "note",              :limit => nil
    t.string   "loc_file",          :limit => nil, :null => false
    t.integer  "loc_line",                         :null => false
    t.string   "url",               :limit => nil
    t.datetime "timestamp_enter"
    t.datetime "timestamp_lastmod"
    t.datetime "timestamp_found"
    t.integer  "marking"
    t.string   "loc_file_hash",     :limit => nil
    t.string   "confirmation",      :limit => nil
  end

  add_index "error_full", ["error_type", "error_subtype", "project", "project_version", "loc_file", "loc_line"], :name => "sqlite_autoindex_error_full_1", :unique => true

  create_table "error_tool_rel", :id => false, :force => true do |t|
    t.integer "tool_id",  :null => false
    t.integer "error_id", :null => false
  end

  add_index "error_tool_rel", ["tool_id", "error_id"], :name => "sqlite_autoindex_error_tool_rel_1", :unique => true

  create_table "error_trace", :force => true do |t|
    t.integer "error_id"
    t.string  "trace",    :limit => nil, :null => false
  end

  create_table "error_type", :force => true do |t|
    t.string  "name"
    t.string  "short_description", :null => false
    t.integer "CWE_error"
  end

  add_index "error_type", ["name"], :name => "sqlite_autoindex_error_type_1", :unique => true

  create_table "error_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "errors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project", :force => true do |t|
    t.string "name"
    t.string "url",         :limit => nil
    t.string "description", :limit => nil
  end

  add_index "project", ["name"], :name => "sqlite_autoindex_project_1", :unique => true

  create_table "tool", :force => true do |t|
    t.string "name",                       :null => false
    t.string "version",     :limit => 32
    t.string "url",         :limit => nil
    t.string "description", :limit => nil
  end

  add_index "tool", ["name", "version"], :name => "sqlite_autoindex_tool_1", :unique => true

  create_table "user", :force => true do |t|
    t.string "name"
    t.string "affilitation"
    t.string "login"
    t.string "password",     :limit => 128
  end

  add_index "user", ["login"], :name => "sqlite_autoindex_user_1", :unique => true

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

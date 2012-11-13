# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121113054723) do

  create_table "engagements", :force => true do |t|
    t.integer "organisation_id"
    t.integer "team_id"
  end

  create_table "facts", :force => true do |t|
    t.integer  "person_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "person_id"
    t.integer  "team_id"
    t.date     "started"
    t.date     "ended"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "track"
    t.string   "secret"
    t.string   "pending_approval_token"
    t.boolean  "hidden"
    t.string   "role"
  end

  create_table "messages", :force => true do |t|
    t.integer  "person_id"
    t.integer  "team_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.string   "domains"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "account"
    t.string   "full_name"
    t.string   "chinese_name"
    t.string   "preferred_name"
    t.string   "email"
    t.string   "pinyin_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "persona_id"
    t.integer  "track"
    t.string   "secret"
    t.string   "phone"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "weibo"
    t.string   "appnet"
    t.string   "github"
    t.string   "url"
    t.string   "auth_token"
    t.float    "lat"
    t.float    "lng"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
    t.integer  "creator_id"
  end

end

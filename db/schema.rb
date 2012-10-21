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

ActiveRecord::Schema.define(:version => 20121009112203) do

  create_table "comment_evaluations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "kind"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "body"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "post_evaluations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "kind"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",    :limit => 255
    t.string   "title"
    t.string   "body"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "domain",                    :default => ""
    t.string   "image",                     :default => ""
    t.boolean  "available",                 :default => true
  end

  create_table "posts_tags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "project_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "role",       :default => 1
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_public"
    t.boolean  "available",                  :default => true
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "owner_id",    :limit => 255, :default => 1
  end

  create_table "stocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "available"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.boolean  "available",  :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "profile_image_filename", :default => ""
    t.boolean  "available",              :default => true
    t.string   "password_digest"
    t.string   "uuid"
  end

end

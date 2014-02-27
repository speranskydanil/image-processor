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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20000000000070) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "node_statuses", force: true do |t|
    t.string   "name"
    t.integer  "position",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_statuses", ["position"], name: "index_node_statuses_on_position", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "status_id"
    t.integer  "n_sided",     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["description"], name: "index_nodes_on_description", length: {"description"=>20}, using: :btree
  add_index "nodes", ["name"], name: "index_nodes_on_name", using: :btree
  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id", using: :btree
  add_index "nodes", ["status_id"], name: "index_nodes_on_status_id", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "position",           default: 0
    t.integer  "node_id"
    t.string   "status",             default: "free"
    t.integer  "angle"
    t.integer  "x1"
    t.integer  "y1"
    t.integer  "x2"
    t.integer  "y2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "raw_file_name"
    t.string   "raw_content_type"
    t.integer  "raw_file_size"
    t.datetime "raw_updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pages", ["node_id"], name: "index_pages_on_node_id", using: :btree
  add_index "pages", ["position"], name: "index_pages_on_position", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

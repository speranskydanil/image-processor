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

ActiveRecord::Schema.define(version: 20150322045048) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["user_id"], name: "index_delayed_jobs_on_user_id", using: :btree

  create_table "node_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_statuses", ["position"], name: "index_node_statuses_on_position", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.text     "description",                limit: 65535
    t.integer  "parent_id",                  limit: 4
    t.integer  "status_id",                  limit: 4
    t.integer  "n_sided",                    limit: 4,     default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archive_file_name",          limit: 255
    t.string   "archive_content_type",       limit: 255
    t.integer  "archive_file_size",          limit: 4
    t.datetime "archive_updated_at"
    t.integer  "pages_total",                limit: 4,     default: 0
    t.integer  "pages_processed_total",      limit: 4,     default: 0
    t.integer  "pages_unprocessed_total",    limit: 4,     default: 0
    t.integer  "children_total",             limit: 4,     default: 0
    t.integer  "children_processed_total",   limit: 4,     default: 0
    t.integer  "children_unprocessed_total", limit: 4,     default: 0
  end

  add_index "nodes", ["description"], name: "index_nodes_on_description", length: {"description"=>20}, using: :btree
  add_index "nodes", ["name"], name: "index_nodes_on_name", using: :btree
  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id", using: :btree
  add_index "nodes", ["status_id"], name: "index_nodes_on_status_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "position",           limit: 4,                           default: 0
    t.integer  "node_id",            limit: 4
    t.string   "status",             limit: 255,                         default: "free"
    t.decimal  "angle",                          precision: 5, scale: 2
    t.integer  "x1",                 limit: 4
    t.integer  "y1",                 limit: 4
    t.integer  "x2",                 limit: 4
    t.integer  "y2",                 limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "raw_file_name",      limit: 255
    t.string   "raw_content_type",   limit: 255
    t.integer  "raw_file_size",      limit: 4
    t.datetime "raw_updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.boolean  "processed",          limit: 1,                           default: false
  end

  add_index "pages", ["node_id"], name: "index_pages_on_node_id", using: :btree
  add_index "pages", ["position"], name: "index_pages_on_position", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "right_ids",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  limit: 255
    t.string   "last_sign_in_ip",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

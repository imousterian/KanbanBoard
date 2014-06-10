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

ActiveRecord::Schema.define(version: 20140610012951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "kanban_milestones", force: true do |t|
    t.string   "kms_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kanban_id"
  end

  add_index "kanban_milestones", ["kanban_id"], name: "index_kanban_milestones_on_kanban_id", using: :btree

  create_table "kanbans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "settings"
    t.string   "columnholder"
  end

  create_table "kanbans_organizations", force: true do |t|
    t.integer "kanban_id"
    t.integer "organization_id"
  end

  create_table "milestones", force: true do |t|
    t.string   "milestone_key"
    t.string   "milestone_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kanban_milestone_id"
    t.integer  "organization_id"
  end

  add_index "milestones", ["kanban_milestone_id"], name: "index_milestones_on_kanban_milestone_id", using: :btree
  add_index "milestones", ["organization_id"], name: "index_milestones_on_organization_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.hstore   "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "org_columnholder"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end

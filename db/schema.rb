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

ActiveRecord::Schema.define(version: 20131225160144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: true do |t|
    t.string   "name"
    t.integer  "dynos"
    t.integer  "workers"
    t.integer  "repo_size"
    t.integer  "slug_size"
    t.string   "stack"
    t.string   "requested_stack"
    t.string   "create_status"
    t.string   "repo_migrate_status"
    t.boolean  "owner_delinquent"
    t.string   "owner_email"
    t.string   "owner_name"
    t.string   "web_url"
    t.string   "git_url"
    t.string   "buildpack_provided_description"
    t.string   "tier"
    t.string   "region"
    t.boolean  "maintenance"
    t.datetime "ping_disabled_at"
    t.integer  "http_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["name"], name: "index_apps_on_name", using: :btree

  create_table "heroku_processes", force: true do |t|
    t.string   "heroku_id"
    t.string   "app_name"
    t.string   "pretty_state"
    t.string   "heroku_type"
    t.string   "process"
    t.string   "state"
    t.string   "command"
    t.integer  "elapsed"
    t.datetime "transitioned_at"
    t.integer  "release"
    t.string   "action"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "heroku_processes", ["heroku_id"], name: "index_heroku_processes_on_heroku_id", using: :btree

end

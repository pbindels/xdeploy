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

ActiveRecord::Schema.define(version: 20131023222053) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "artifacts", force: true do |t|
    t.integer  "project_id"
    t.integer  "service_id"
    t.string   "name"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artifacts", ["project_id"], name: "index_artifacts_on_project_id", using: :btree
  add_index "artifacts", ["service_id"], name: "index_artifacts_on_service_id", using: :btree

  create_table "deployments", force: true do |t|
    t.integer  "project_id"
    t.integer  "service_id"
    t.integer  "environment_id"
    t.string   "job_uuid"
    t.string   "status"
    t.string   "pct_complete"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artifact_id",    null: false
    t.integer  "user_id",        null: false
    t.string   "log_path"
  end

  add_index "deployments", ["environment_id"], name: "index_deployments_on_environment_id", using: :btree
  add_index "deployments", ["project_id"], name: "index_deployments_on_project_id", using: :btree
  add_index "deployments", ["service_id"], name: "index_deployments_on_service_id", using: :btree

  create_table "environments", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "env_id",     null: false
  end

  create_table "host_groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "host_to_host_group", force: true do |t|
    t.integer  "host_id"
    t.integer  "host_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", force: true do |t|
    t.string   "name"
    t.string   "ohai_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", force: true do |t|
    t.datetime "start_date"
    t.string   "title"
    t.text     "content"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_to_environment", force: true do |t|
    t.integer  "project_id"
    t.integer  "environment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_to_environment", ["environment_id"], name: "index_project_to_environment_on_environment_id", using: :btree
  add_index "project_to_environment", ["project_id"], name: "index_project_to_environment_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_repositories", force: true do |t|
    t.integer  "project_id_id"
    t.integer  "repository_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_repositories", ["project_id_id"], name: "index_projects_repositories_on_project_id_id", using: :btree
  add_index "projects_repositories", ["repository_id_id"], name: "index_projects_repositories_on_repository_id_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.string   "uuid"
    t.string   "url"
    t.text     "properties"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repositories", ["type"], name: "index_repositories_on_type", using: :btree
  add_index "repositories", ["uuid"], name: "index_repositories_on_uuid", using: :btree

  create_table "service_to_environment", force: true do |t|
    t.integer  "service_id"
    t.integer  "environment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_to_environment", ["environment_id"], name: "index_service_to_environment_on_environment_id", using: :btree
  add_index "service_to_environment", ["service_id"], name: "index_service_to_environment_on_service_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["project_id"], name: "index_services_on_project_id", using: :btree

  create_table "tokens", force: true do |t|
    t.string   "tokenable_type"
    t.integer  "tokenable_id"
    t.string   "name"
    t.text     "encrypted_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end

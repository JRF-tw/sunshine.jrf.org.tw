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

ActiveRecord::Schema.define(version: 20150729090055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "postgis"

  create_table "awards", force: true do |t|
    t.integer  "profile_id"
    t.string   "award_type"
    t.string   "unit"
    t.text     "content"
    t.date     "publish_at"
    t.text     "source"
    t.string   "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awards", ["profile_id"], :name => "index_awards_on_profile_id"

  create_table "careers", force: true do |t|
    t.integer  "profile_id"
    t.string   "career_type"
    t.string   "old_unit"
    t.string   "old_title"
    t.string   "old_assign_court"
    t.string   "old_assign_judicial"
    t.string   "old_pt"
    t.string   "new_unit"
    t.string   "new_title"
    t.string   "new_assign_court"
    t.string   "new_assign_judicial"
    t.string   "new_pt"
    t.date     "start_at"
    t.date     "end_at"
    t.date     "publish_at"
    t.text     "source"
    t.string   "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "careers", ["profile_id"], :name => "index_careers_on_profile_id"

  create_table "educations", force: true do |t|
    t.integer  "profile_id"
    t.string   "title"
    t.text     "content"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["profile_id"], :name => "index_educations_on_profile_id"

  create_table "licenses", force: true do |t|
    t.integer  "profile_id"
    t.string   "license_type"
    t.string   "unit"
    t.string   "title"
    t.date     "publish_at"
    t.text     "source"
    t.string   "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "licenses", ["profile_id"], :name => "index_licenses_on_profile_id"

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "current"
    t.string   "avatar"
    t.string   "gender"
    t.string   "gender_source"
    t.integer  "birth_year"
    t.string   "birth_year_source"
    t.integer  "stage"
    t.string   "stage_source"
    t.string   "appointment"
    t.string   "appointment_source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["current"], :name => "index_profiles_on_current"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

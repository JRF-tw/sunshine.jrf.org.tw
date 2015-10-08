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

ActiveRecord::Schema.define(version: 20151008080158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "hstore"

  create_table "articles", force: true do |t|
    t.integer  "profile_id"
    t.string   "article_type"
    t.integer  "publish_year"
    t.date     "paper_publish_at"
    t.date     "news_publish_at"
    t.string   "book_title"
    t.string   "title"
    t.string   "journal_no"
    t.string   "journal_periods"
    t.integer  "start_page"
    t.integer  "end_page"
    t.string   "editor"
    t.string   "author"
    t.string   "publisher"
    t.string   "publish_locat"
    t.string   "department"
    t.string   "degree"
    t.string   "source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["profile_id"], :name => "index_articles_on_profile_id"

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

  create_table "banners", force: true do |t|
    t.string   "pic_l"
    t.string   "pic_m"
    t.string   "pic_s"
    t.integer  "weight"
    t.boolean  "is_hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "courts", force: true do |t|
    t.string   "court_type"
    t.string   "full_name"
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courts", ["court_type"], :name => "index_courts_on_court_type"
  add_index "courts", ["full_name"], :name => "index_courts_on_full_name"
  add_index "courts", ["name"], :name => "index_courts_on_name"

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

  create_table "judgment_judges", force: true do |t|
    t.integer  "profile_id"
    t.integer  "judgment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judgment_judges", ["judgment_id"], :name => "index_judgment_judges_on_judgment_id"
  add_index "judgment_judges", ["profile_id", "judgment_id"], :name => "index_judgment_judges_on_profile_id_and_judgment_id"
  add_index "judgment_judges", ["profile_id"], :name => "index_judgment_judges_on_profile_id"

  create_table "judgment_prosecutors", force: true do |t|
    t.integer  "profile_id"
    t.integer  "judgment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judgment_prosecutors", ["judgment_id"], :name => "index_judgment_prosecutors_on_judgment_id"
  add_index "judgment_prosecutors", ["profile_id", "judgment_id"], :name => "index_judgment_prosecutors_on_profile_id_and_judgment_id"
  add_index "judgment_prosecutors", ["profile_id"], :name => "index_judgment_prosecutors_on_profile_id"

  create_table "judgments", force: true do |t|
    t.integer  "court_id"
    t.integer  "main_judge_id"
    t.integer  "presiding_judge_id"
    t.string   "judge_no"
    t.string   "court_no"
    t.string   "judge_type"
    t.date     "judge_date"
    t.text     "reason"
    t.text     "content"
    t.text     "comment"
    t.string   "source"
    t.string   "source_link"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judgments", ["court_id"], :name => "index_judgments_on_court_id"
  add_index "judgments", ["court_no"], :name => "index_judgments_on_court_no"
  add_index "judgments", ["judge_no"], :name => "index_judgments_on_judge_no"
  add_index "judgments", ["main_judge_id"], :name => "index_judgments_on_main_judge_id"

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

  create_table "procedures", force: true do |t|
    t.integer  "profile_id"
    t.integer  "suit_id"
    t.string   "unit"
    t.string   "title"
    t.string   "procedure_unit"
    t.text     "procedure_content"
    t.text     "procedure_result"
    t.string   "procedure_no"
    t.date     "procedure_date"
    t.integer  "suit_no"
    t.text     "source"
    t.string   "source_link"
    t.string   "punish_link"
    t.string   "file"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedures", ["profile_id"], :name => "index_procedures_on_profile_id"
  add_index "procedures", ["suit_id"], :name => "index_procedures_on_suit_id"

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
    t.string   "current_court"
    t.boolean  "is_active"
  end

  add_index "profiles", ["current"], :name => "index_profiles_on_current"
  add_index "profiles", ["current_court"], :name => "index_profiles_on_current_court"
  add_index "profiles", ["is_active"], :name => "index_profiles_on_is_active"

  create_table "punishments", force: true do |t|
    t.integer  "profile_id"
    t.string   "decision_unit"
    t.string   "unit"
    t.string   "title"
    t.string   "claimant"
    t.string   "punish_no"
    t.string   "decision_no"
    t.string   "punish_type"
    t.date     "relevant_date"
    t.text     "decision_result"
    t.text     "decision_source"
    t.text     "reason"
    t.boolean  "is_anonymous"
    t.text     "anonymous_source"
    t.string   "anonymous"
    t.text     "origin_desc"
    t.string   "proposer"
    t.string   "plaintiff"
    t.string   "defendant"
    t.text     "reply"
    t.text     "reply_source"
    t.text     "punish"
    t.text     "content"
    t.text     "summary"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "punishments", ["profile_id"], :name => "index_punishments_on_profile_id"

  create_table "reviews", force: true do |t|
    t.integer  "profile_id"
    t.date     "publish_at"
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.text     "comment"
    t.string   "no"
    t.string   "source"
    t.string   "file"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["profile_id"], :name => "index_reviews_on_profile_id"

  create_table "suit_banners", force: true do |t|
    t.string   "pic_l"
    t.string   "pic_m"
    t.string   "pic_s"
    t.string   "url"
    t.string   "alt_string"
    t.string   "title"
    t.text     "content"
    t.integer  "weight"
    t.boolean  "is_hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suit_judges", force: true do |t|
    t.integer  "suit_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suit_judges", ["profile_id", "suit_id"], :name => "index_suit_judges_on_profile_id_and_suit_id"
  add_index "suit_judges", ["profile_id"], :name => "index_suit_judges_on_profile_id"
  add_index "suit_judges", ["suit_id"], :name => "index_suit_judges_on_suit_id"

  create_table "suit_prosecutors", force: true do |t|
    t.integer  "suit_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suit_prosecutors", ["profile_id", "suit_id"], :name => "index_suit_prosecutors_on_profile_id_and_suit_id"
  add_index "suit_prosecutors", ["profile_id"], :name => "index_suit_prosecutors_on_profile_id"
  add_index "suit_prosecutors", ["suit_id"], :name => "index_suit_prosecutors_on_suit_id"

  create_table "suits", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.string   "state"
    t.string   "pic"
    t.integer  "suit_no"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

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


ActiveRecord::Schema.define(version: 20160829035239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "postgis"

  create_table "articles", force: :cascade do |t|
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
    t.text     "source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "articles", ["is_hidden"], name: "index_articles_on_is_hidden", using: :btree
  add_index "articles", ["profile_id"], name: "index_articles_on_profile_id", using: :btree

  create_table "awards", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "award_type"
    t.string   "unit"
    t.text     "content"
    t.date     "publish_at"
    t.text     "source"
    t.text     "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "awards", ["is_hidden"], name: "index_awards_on_is_hidden", using: :btree
  add_index "awards", ["profile_id"], name: "index_awards_on_profile_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "pic_l"
    t.string   "pic_m"
    t.string   "pic_s"
    t.integer  "weight"
    t.boolean  "is_hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banners", ["is_hidden"], name: "index_banners_on_is_hidden", using: :btree

  create_table "branches", force: :cascade do |t|
    t.integer  "court_id"
    t.integer  "judge_id"
    t.string   "name"
    t.string   "chamber_name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "missed",       default: false
  end

  add_index "branches", ["chamber_name"], name: "index_branches_on_chamber_name", using: :btree
  add_index "branches", ["court_id", "judge_id"], name: "index_branches_on_court_id_and_judge_id", using: :btree
  add_index "branches", ["court_id"], name: "index_branches_on_court_id", using: :btree
  add_index "branches", ["judge_id"], name: "index_branches_on_judge_id", using: :btree
  add_index "branches", ["missed", "court_id"], name: "index_branches_on_missed_and_court_id", using: :btree
  add_index "branches", ["missed", "judge_id", "court_id"], name: "index_branches_on_missed_and_judge_id_and_court_id", using: :btree
  add_index "branches", ["missed", "judge_id"], name: "index_branches_on_missed_and_judge_id", using: :btree
  add_index "branches", ["missed"], name: "index_branches_on_missed", using: :btree
  add_index "branches", ["name"], name: "index_branches_on_name", using: :btree

  create_table "careers", force: :cascade do |t|
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
    t.text     "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "careers", ["is_hidden"], name: "index_careers_on_is_hidden", using: :btree
  add_index "careers", ["profile_id"], name: "index_careers_on_profile_id", using: :btree

  create_table "court_observers", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "email",                                  null: false
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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "phone_number"
    t.string   "school"
    t.string   "student_number"
    t.string   "department_level"
    t.date     "last_scored_at"
    t.boolean  "subscribe_edm",          default: false
  end

  add_index "court_observers", ["confirmation_token"], name: "index_court_observers_on_confirmation_token", unique: true, using: :btree
  add_index "court_observers", ["email"], name: "index_court_observers_on_email", unique: true, using: :btree
  add_index "court_observers", ["last_scored_at"], name: "index_court_observers_on_last_scored_at", using: :btree
  add_index "court_observers", ["reset_password_token"], name: "index_court_observers_on_reset_password_token", unique: true, using: :btree
  add_index "court_observers", ["school"], name: "index_court_observers_on_school", using: :btree
  add_index "court_observers", ["subscribe_edm"], name: "index_court_observers_on_subscribe_edm", using: :btree

  create_table "courts", force: :cascade do |t|
    t.string   "court_type"
    t.string   "full_name"
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden",  default: true
    t.string   "code"
    t.string   "scrap_name"
  end

  add_index "courts", ["code"], name: "index_courts_on_code", using: :btree
  add_index "courts", ["court_type"], name: "index_courts_on_court_type", using: :btree
  add_index "courts", ["full_name"], name: "index_courts_on_full_name", using: :btree
  add_index "courts", ["is_hidden"], name: "index_courts_on_is_hidden", using: :btree
  add_index "courts", ["name"], name: "index_courts_on_name", using: :btree
  add_index "courts", ["scrap_name"], name: "index_courts_on_scrap_name", using: :btree

  create_table "educations", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "title"
    t.text     "content"
    t.date     "start_at"
    t.date     "end_at"
    t.text     "source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "educations", ["is_hidden"], name: "index_educations_on_is_hidden", using: :btree
  add_index "educations", ["profile_id"], name: "index_educations_on_profile_id", using: :btree

  create_table "judges", force: :cascade do |t|
    t.string   "name"
    t.integer  "current_court_id"
    t.string   "avatar"
    t.string   "gender"
    t.string   "gender_source"
    t.integer  "birth_year"
    t.string   "birth_year_source"
    t.integer  "stage"
    t.string   "stage_source"
    t.string   "appointment"
    t.string   "appointment_source"
    t.string   "memo"
    t.boolean  "is_active",          default: true
    t.boolean  "is_hidden",          default: true
    t.integer  "punishments_count",  default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "judges", ["current_court_id"], name: "index_judges_on_current_court_id", using: :btree
  add_index "judges", ["is_active"], name: "index_judges_on_is_active", using: :btree
  add_index "judges", ["is_hidden"], name: "index_judges_on_is_hidden", using: :btree

  create_table "judgment_judges", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "judgment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judgment_judges", ["judgment_id"], name: "index_judgment_judges_on_judgment_id", using: :btree
  add_index "judgment_judges", ["profile_id", "judgment_id"], name: "index_judgment_judges_on_profile_id_and_judgment_id", using: :btree
  add_index "judgment_judges", ["profile_id"], name: "index_judgment_judges_on_profile_id", using: :btree

  create_table "judgment_prosecutors", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "judgment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "judgment_prosecutors", ["judgment_id"], name: "index_judgment_prosecutors_on_judgment_id", using: :btree
  add_index "judgment_prosecutors", ["profile_id", "judgment_id"], name: "index_judgment_prosecutors_on_profile_id_and_judgment_id", using: :btree
  add_index "judgment_prosecutors", ["profile_id"], name: "index_judgment_prosecutors_on_profile_id", using: :btree

  create_table "judgments", force: :cascade do |t|
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
    t.text     "source"
    t.text     "source_link"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "judgments", ["court_id"], name: "index_judgments_on_court_id", using: :btree
  add_index "judgments", ["court_no"], name: "index_judgments_on_court_no", using: :btree
  add_index "judgments", ["is_hidden"], name: "index_judgments_on_is_hidden", using: :btree
  add_index "judgments", ["judge_no"], name: "index_judgments_on_judge_no", using: :btree
  add_index "judgments", ["main_judge_id"], name: "index_judgments_on_main_judge_id", using: :btree

  create_table "lawyers", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "current"
    t.string   "avatar"
    t.string   "gender"
    t.integer  "birth_year"
    t.string   "memo"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                                  null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "last_sign_in_at"
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "unconfirmed_email"
    t.string   "phone_number"
    t.string   "office_number"
    t.boolean  "subscribe_edm",          default: false
  end

  add_index "lawyers", ["confirmation_token"], name: "index_lawyers_on_confirmation_token", unique: true, using: :btree
  add_index "lawyers", ["email"], name: "index_lawyers_on_email", unique: true, using: :btree
  add_index "lawyers", ["reset_password_token"], name: "index_lawyers_on_reset_password_token", unique: true, using: :btree
  add_index "lawyers", ["subscribe_edm"], name: "index_lawyers_on_subscribe_edm", using: :btree

  create_table "licenses", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "license_type"
    t.string   "unit"
    t.string   "title"
    t.date     "publish_at"
    t.text     "source"
    t.text     "source_link"
    t.text     "origin_desc"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "licenses", ["is_hidden"], name: "index_licenses_on_is_hidden", using: :btree
  add_index "licenses", ["profile_id"], name: "index_licenses_on_profile_id", using: :btree

  create_table "parties", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.string   "identify_number",                          null: false
    t.string   "phone_number"
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "email"
    t.string   "unconfirmed_email"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.boolean  "imposter",                 default: false
    t.string   "imposter_identify_number"
    t.datetime "phone_confirmed_at"
    t.boolean  "subscribe_edm",            default: false
  end

  add_index "parties", ["confirmation_token"], name: "index_parties_on_confirmation_token", unique: true, using: :btree
  add_index "parties", ["email"], name: "index_parties_on_email", unique: true, using: :btree
  add_index "parties", ["imposter"], name: "index_parties_on_imposter", using: :btree
  add_index "parties", ["reset_password_token"], name: "index_parties_on_reset_password_token", unique: true, using: :btree
  add_index "parties", ["subscribe_edm"], name: "index_parties_on_subscribe_edm", using: :btree

  create_table "procedures", force: :cascade do |t|
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
    t.text     "source_link"
    t.string   "punish_link"
    t.string   "file"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "procedures", ["is_hidden"], name: "index_procedures_on_is_hidden", using: :btree
  add_index "procedures", ["profile_id"], name: "index_procedures_on_profile_id", using: :btree
  add_index "procedures", ["suit_id"], name: "index_procedures_on_suit_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "current"
    t.string   "avatar"
    t.string   "gender"
    t.text     "gender_source"
    t.integer  "birth_year"
    t.text     "birth_year_source"
    t.integer  "stage"
    t.text     "stage_source"
    t.string   "appointment"
    t.text     "appointment_source"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_court"
    t.boolean  "is_active"
    t.boolean  "is_hidden"
    t.integer  "punishments_count",  default: 0
    t.string   "current_department"
    t.string   "current_branch"
  end

  add_index "profiles", ["current"], name: "index_profiles_on_current", using: :btree
  add_index "profiles", ["current_court"], name: "index_profiles_on_current_court", using: :btree
  add_index "profiles", ["is_active"], name: "index_profiles_on_is_active", using: :btree
  add_index "profiles", ["is_hidden"], name: "index_profiles_on_is_hidden", using: :btree

  create_table "punishments", force: :cascade do |t|
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
    t.boolean  "is_hidden"
    t.text     "status"
  end

  add_index "punishments", ["is_hidden"], name: "index_punishments_on_is_hidden", using: :btree
  add_index "punishments", ["profile_id"], name: "index_punishments_on_profile_id", using: :btree

  create_table "redactor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable", using: :btree
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "profile_id"
    t.date     "publish_at"
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.text     "comment"
    t.string   "no"
    t.text     "source"
    t.string   "file"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
  end

  add_index "reviews", ["is_hidden"], name: "index_reviews_on_is_hidden", using: :btree
  add_index "reviews", ["profile_id"], name: "index_reviews_on_profile_id", using: :btree

  create_table "schedule_scores", force: :cascade do |t|
    t.integer  "schedule_id"
    t.integer  "judge_id"
    t.integer  "schedule_rater_id"
    t.string   "schedule_rater_type"
    t.integer  "rating_score"
    t.integer  "command_score"
    t.integer  "attitude_score"
    t.hstore   "data"
    t.boolean  "appeal_judge",        default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "story_id"
  end

  add_index "schedule_scores", ["appeal_judge"], name: "index_schedule_scores_on_appeal_judge", using: :btree
  add_index "schedule_scores", ["judge_id", "schedule_rater_id"], name: "index_schedule_scores_on_judge_id_and_schedule_rater_id", using: :btree
  add_index "schedule_scores", ["judge_id"], name: "index_schedule_scores_on_judge_id", using: :btree
  add_index "schedule_scores", ["schedule_id"], name: "index_schedule_scores_on_schedule_id", using: :btree
  add_index "schedule_scores", ["story_id"], name: "index_schedule_scores_on_story_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "court_id"
    t.string   "branch_name"
    t.date     "start_on"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "branch_judge_id"
    t.datetime "start_at"
    t.string   "courtroom"
  end

  add_index "schedules", ["branch_judge_id", "court_id", "story_id"], name: "index_schedules_on_branch_judge_id_and_court_id_and_story_id", using: :btree
  add_index "schedules", ["branch_judge_id", "court_id"], name: "index_schedules_on_branch_judge_id_and_court_id", using: :btree
  add_index "schedules", ["branch_judge_id", "story_id"], name: "index_schedules_on_branch_judge_id_and_story_id", using: :btree
  add_index "schedules", ["branch_judge_id"], name: "index_schedules_on_branch_judge_id", using: :btree
  add_index "schedules", ["court_id"], name: "index_schedules_on_court_id", using: :btree
  add_index "schedules", ["courtroom"], name: "index_schedules_on_courtroom", using: :btree
  add_index "schedules", ["start_at"], name: "index_schedules_on_start_at", using: :btree
  add_index "schedules", ["start_on"], name: "index_schedules_on_start_on", using: :btree
  add_index "schedules", ["story_id", "court_id"], name: "index_schedules_on_story_id_and_court_id", using: :btree
  add_index "schedules", ["story_id"], name: "index_schedules_on_story_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.integer  "court_id"
    t.integer  "main_judge_id"
    t.string   "story_type"
    t.integer  "year"
    t.string   "word_type"
    t.integer  "number"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "party_names"
    t.text     "lawyer_names"
    t.text     "judges_names"
    t.text     "prosecutor_names"
    t.boolean  "is_adjudge",       default: false
    t.date     "adjudge_date"
    t.date     "pronounce_date"
    t.boolean  "is_pronounce",     default: false
  end

  add_index "stories", ["adjudge_date"], name: "index_stories_on_adjudge_date", using: :btree
  add_index "stories", ["court_id"], name: "index_stories_on_court_id", using: :btree
  add_index "stories", ["is_adjudge"], name: "index_stories_on_is_adjudge", using: :btree
  add_index "stories", ["is_pronounce"], name: "index_stories_on_is_pronounce", using: :btree
  add_index "stories", ["main_judge_id"], name: "index_stories_on_main_judge_id", using: :btree
  add_index "stories", ["pronounce_date"], name: "index_stories_on_pronounce_date", using: :btree

  create_table "story_relations", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "people_id"
    t.string   "people_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "story_relations", ["people_id", "people_type"], name: "index_story_relations_on_people_id_and_people_type", using: :btree
  add_index "story_relations", ["people_id"], name: "index_story_relations_on_people_id", using: :btree
  add_index "story_relations", ["people_type"], name: "index_story_relations_on_people_type", using: :btree
  add_index "story_relations", ["story_id", "people_id", "people_type"], name: "index_story_relations_on_story_id_and_people_id_and_people_type", using: :btree
  add_index "story_relations", ["story_id", "people_id"], name: "index_story_relations_on_story_id_and_people_id", using: :btree
  add_index "story_relations", ["story_id", "people_type"], name: "index_story_relations_on_story_id_and_people_type", using: :btree
  add_index "story_relations", ["story_id"], name: "index_story_relations_on_story_id", using: :btree

  create_table "story_subscriptions", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "story_subscriptions", ["story_id", "subscriber_id", "subscriber_type"], name: "story_subscriptions_full_index", unique: true, using: :btree
  add_index "story_subscriptions", ["story_id", "subscriber_id"], name: "index_story_subscriptions_on_story_id_and_subscriber_id", using: :btree
  add_index "story_subscriptions", ["story_id", "subscriber_type"], name: "index_story_subscriptions_on_story_id_and_subscriber_type", using: :btree
  add_index "story_subscriptions", ["story_id"], name: "index_story_subscriptions_on_story_id", using: :btree
  add_index "story_subscriptions", ["subscriber_id", "subscriber_type"], name: "index_story_subscriptions_on_subscriber_id_and_subscriber_type", using: :btree
  add_index "story_subscriptions", ["subscriber_id"], name: "index_story_subscriptions_on_subscriber_id", using: :btree
  add_index "story_subscriptions", ["subscriber_type"], name: "index_story_subscriptions_on_subscriber_type", using: :btree

  create_table "suit_banners", force: :cascade do |t|
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

  add_index "suit_banners", ["is_hidden"], name: "index_suit_banners_on_is_hidden", using: :btree

  create_table "suit_judges", force: :cascade do |t|
    t.integer  "suit_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suit_judges", ["profile_id", "suit_id"], name: "index_suit_judges_on_profile_id_and_suit_id", using: :btree
  add_index "suit_judges", ["profile_id"], name: "index_suit_judges_on_profile_id", using: :btree
  add_index "suit_judges", ["suit_id"], name: "index_suit_judges_on_suit_id", using: :btree

  create_table "suit_prosecutors", force: :cascade do |t|
    t.integer  "suit_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suit_prosecutors", ["profile_id", "suit_id"], name: "index_suit_prosecutors_on_profile_id_and_suit_id", using: :btree
  add_index "suit_prosecutors", ["profile_id"], name: "index_suit_prosecutors_on_profile_id", using: :btree
  add_index "suit_prosecutors", ["suit_id"], name: "index_suit_prosecutors_on_suit_id", using: :btree

  create_table "suits", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.string   "state"
    t.string   "pic"
    t.integer  "suit_no"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_hidden"
    t.integer  "procedure_count", default: 0
  end

  add_index "suits", ["is_hidden"], name: "index_suits_on_is_hidden", using: :btree

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verdict_relations", force: :cascade do |t|
    t.integer  "verdict_id"
    t.integer  "person_id"
    t.string   "person_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "verdict_relations", ["person_id", "person_type"], name: "index_verdict_relations_on_person_id_and_person_type", using: :btree
  add_index "verdict_relations", ["person_id"], name: "index_verdict_relations_on_person_id", using: :btree
  add_index "verdict_relations", ["person_type"], name: "index_verdict_relations_on_person_type", using: :btree
  add_index "verdict_relations", ["verdict_id", "person_id", "person_type"], name: "verdict_relations_full_index", using: :btree
  add_index "verdict_relations", ["verdict_id", "person_id"], name: "index_verdict_relations_on_verdict_id_and_person_id", using: :btree
  add_index "verdict_relations", ["verdict_id", "person_type"], name: "index_verdict_relations_on_verdict_id_and_person_type", using: :btree
  add_index "verdict_relations", ["verdict_id"], name: "index_verdict_relations_on_verdict_id", using: :btree

  create_table "verdict_scores", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "judge_id"
    t.integer  "verdict_rater_id"
    t.string   "verdict_rater_type"
    t.integer  "quality_score"
    t.integer  "rating_score"
    t.hstore   "data"
    t.boolean  "appeal_judge"
    t.integer  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "verdict_scores", ["appeal_judge"], name: "index_verdict_scores_on_appeal_judge", using: :btree
  add_index "verdict_scores", ["judge_id"], name: "index_verdict_scores_on_judge_id", using: :btree
  add_index "verdict_scores", ["status"], name: "index_verdict_scores_on_status", using: :btree
  add_index "verdict_scores", ["story_id"], name: "index_verdict_scores_on_story_id", using: :btree
  add_index "verdict_scores", ["verdict_rater_id", "verdict_rater_type"], name: "index_verdict_scores_on_verdict_rater_id_and_verdict_rater_type", using: :btree

  create_table "verdicts", force: :cascade do |t|
    t.integer  "story_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "file"
    t.text     "party_names"
    t.text     "lawyer_names"
    t.text     "judges_names"
    t.text     "prosecutor_names"
    t.boolean  "is_judgment",      default: false
    t.date     "adjudge_date"
    t.integer  "main_judge_id"
    t.string   "main_judge_name"
    t.date     "publish_date"
  end

  add_index "verdicts", ["adjudge_date"], name: "index_verdicts_on_adjudge_date", using: :btree
  add_index "verdicts", ["is_judgment"], name: "index_verdicts_on_is_judgment", using: :btree
  add_index "verdicts", ["main_judge_id", "story_id"], name: "index_verdicts_on_main_judge_id_and_story_id", using: :btree
  add_index "verdicts", ["main_judge_id"], name: "index_verdicts_on_main_judge_id", using: :btree
  add_index "verdicts", ["publish_date"], name: "index_verdicts_on_publish_date", using: :btree

end

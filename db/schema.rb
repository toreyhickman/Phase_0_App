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

ActiveRecord::Schema.define(version: 20131108192538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cohorts", primary_key: "socrates_id", force: true do |t|
    t.text     "name"
    t.text     "email"
    t.text     "location"
    t.datetime "start_date"
    t.boolean  "in_session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercise_attempts", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.text     "code"
    t.datetime "submitted_at"
  end

  add_index "exercise_attempts", ["exercise_id"], name: "index_exercise_attempts_on_exercise_id", using: :btree
  add_index "exercise_attempts", ["user_id"], name: "index_exercise_attempts_on_user_id", using: :btree

  create_table "exercises", primary_key: "socrates_id", force: true do |t|
    t.string "title"
  end

  create_table "users", primary_key: "socrates_id", force: true do |t|
    t.integer  "cohort_id"
    t.string   "name"
    t.string   "email"
    t.string   "github"
    t.string   "twitter"
    t.string   "blog_url"
    t.text     "bio"
    t.boolean  "intellectual_flag", default: false
    t.boolean  "cultural_flag",     default: false
    t.boolean  "admin",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cohort_id"], name: "index_users_on_cohort_id", using: :btree

end

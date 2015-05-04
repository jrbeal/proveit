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

ActiveRecord::Schema.define(version: 20150504215350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.boolean "religion"
    t.boolean "politics"
    t.boolean "software"
    t.boolean "culture"
    t.boolean "cars"
    t.boolean "family"
    t.boolean "women"
    t.boolean "sports"
    t.boolean "hardware"
    t.boolean "civil_rights"
    t.boolean "men"
    t.boolean "technology"
    t.boolean "children"
    t.boolean "science"
    t.boolean "computers"
    t.boolean "racism"
    t.boolean "animals"
    t.boolean "school"
  end

  create_table "filters", force: :cascade do |t|
    t.string   "name"
    t.boolean  "contested_opinions"
    t.boolean  "uncontested_opinions"
    t.boolean  "contested_objections"
    t.boolean  "uncontested_objections"
    t.boolean  "comments"
    t.boolean  "initiators"
    t.boolean  "following"
    t.boolean  "active"
    t.boolean  "bookmarks"
    t.boolean  "hot_topics"
    t.boolean  "categories"
    t.boolean  "key_words"
    t.boolean  "levels"
    t.boolean  "range"
    t.boolean  "today"
    t.boolean  "last_week"
    t.boolean  "last_month"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "public"
    t.integer  "user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "hot_topics", force: :cascade do |t|
    t.string  "key_phrase"
    t.integer "count"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.string  "team"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "status"
    t.integer  "level"
    t.float    "score"
    t.text     "support"
    t.integer  "views"
    t.string   "message"
    t.integer  "topic_id"
    t.integer  "points"
    t.integer  "user_id"
    t.string   "kind"
    t.integer  "parent_id"
    t.integer  "children_opinions"
    t.integer  "offspring_opinions"
    t.integer  "children_comments"
    t.integer  "offspring_comments"
  end

  create_table "stories", force: :cascade do |t|
    t.string  "url"
    t.string  "headline"
    t.integer "upvotes"
  end

  create_table "teams", force: :cascade do |t|
    t.string "kind"
  end

  create_table "topics", force: :cascade do |t|
    t.boolean  "private"
    t.boolean  "lone_wolf"
    t.boolean  "teams"
    t.boolean  "public_viewing"
    t.boolean  "public_comments"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "root_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "categories_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "timezone"
    t.string   "language"
    t.binary   "password"
    t.integer  "verbosity"
    t.integer  "default_filter"
    t.boolean  "list"
    t.string   "location"
    t.string   "occupation"
    t.string   "phone"
    t.string   "education"
    t.string   "about"
    t.integer  "opinions"
    t.integer  "comments"
    t.integer  "initiators"
    t.float    "rating"
    t.float    "percentile"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "objections"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users_teams", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
  end

  add_foreign_key "filters", "users"
  add_foreign_key "posts", "posts", column: "parent_id", on_delete: :cascade
  add_foreign_key "posts", "topics", on_delete: :cascade
  add_foreign_key "posts", "users", on_delete: :cascade
  add_foreign_key "topics", "categories", column: "categories_id"
  add_foreign_key "topics", "posts", column: "root_id"
  add_foreign_key "topics", "teams", column: "team1_id"
  add_foreign_key "topics", "teams", column: "team2_id"
  add_foreign_key "users_groups", "groups"
  add_foreign_key "users_groups", "users"
  add_foreign_key "users_teams", "teams"
  add_foreign_key "users_teams", "users"
end

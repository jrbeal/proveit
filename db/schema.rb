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

ActiveRecord::Schema.define(version: 20150610023800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer "owner"
    t.integer "post"
  end

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
    t.integer  "prover_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "owner",   null: false
    t.integer "follows", null: false
  end

  add_index "follows", ["owner", "follows"], name: "index_follows_on_owner_and_follows", unique: true, using: :btree

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "owner"
  end

  create_table "hot_topics", force: :cascade do |t|
    t.string  "key_phrase"
    t.integer "count"
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
    t.string   "kind"
    t.integer  "parent_id"
    t.integer  "children_opinions"
    t.integer  "offspring_opinions"
    t.integer  "children_comments"
    t.integer  "offspring_comments"
    t.integer  "prover_id"
    t.string   "url"
  end

  create_table "provers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provername"
    t.integer  "verbosity"
    t.float    "rating"
    t.float    "percentile"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "offspring_style"
    t.string   "image_url"
    t.text     "aboutme"
    t.string   "education"
    t.string   "occupation"
    t.string   "location"
    t.string   "filter"
    t.integer  "ranking"
    t.float    "highest_rating"
    t.datetime "highest_rating_date"
  end

  add_index "provers", ["email"], name: "index_provers_on_email", unique: true, using: :btree
  add_index "provers", ["provername"], name: "index_provers_on_provername", unique: true, using: :btree
  add_index "provers", ["reset_password_token"], name: "index_provers_on_reset_password_token", unique: true, using: :btree

  create_table "stories", force: :cascade do |t|
    t.string  "url"
    t.string  "headline"
    t.integer "upvotes"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "prover_id"
    t.integer "topic_id"
    t.string  "team_type"
  end

  create_table "topics", force: :cascade do |t|
    t.boolean  "private"
    t.boolean  "lone_wolf"
    t.boolean  "public_viewing"
    t.boolean  "public_comments"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "root_id"
    t.integer  "categories_id"
    t.boolean  "use_teams"
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "prover_id"
  end

  add_foreign_key "bookmarks", "posts", column: "post", on_delete: :cascade
  add_foreign_key "bookmarks", "provers", column: "owner", on_delete: :cascade
  add_foreign_key "filters", "provers"
  add_foreign_key "follows", "provers", column: "follows", on_delete: :cascade
  add_foreign_key "follows", "provers", column: "owner", on_delete: :cascade
  add_foreign_key "groups", "provers", column: "owner"
  add_foreign_key "posts", "posts", column: "parent_id", on_delete: :cascade
  add_foreign_key "posts", "provers", on_delete: :cascade
  add_foreign_key "posts", "topics", on_delete: :cascade
  add_foreign_key "teams", "provers", on_delete: :cascade
  add_foreign_key "teams", "topics", on_delete: :cascade
  add_foreign_key "topics", "categories", column: "categories_id"
  add_foreign_key "topics", "posts", column: "root_id"
  add_foreign_key "users_groups", "groups"
  add_foreign_key "users_groups", "provers"
end

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

ActiveRecord::Schema.define(version: 20160925174716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer "owner"
    t.integer "post"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "categories_filters", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "filter_id",   null: false
  end

  add_index "categories_filters", ["category_id", "filter_id"], name: "index_categories_filters_on_category_id_and_filter_id", unique: true, using: :btree

  create_table "categories_topics", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "topic_id",    null: false
  end

  add_index "categories_topics", ["category_id", "topic_id"], name: "index_categories_topics_on_category_id_and_topic_id", unique: true, using: :btree

  create_table "configs_tables", force: :cascade do |t|
    t.string  "name"
    t.string  "stringvalue"
    t.integer "integervalue"
    t.float   "floatvalue"
  end

  create_table "fallacies", force: :cascade do |t|
    t.string  "name"
    t.integer "folder"
    t.string  "opinion"
    t.string  "support"
    t.string  "url"
  end

  create_table "fallacyfolders", force: :cascade do |t|
    t.string  "name"
    t.integer "parent"
  end

  create_table "filters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "prover_id"
    t.boolean  "sitedefault"
    t.boolean  "opinions"
    t.boolean  "contested"
    t.boolean  "uncontested"
    t.boolean  "initiators"
    t.boolean  "comments"
    t.boolean  "following"
    t.boolean  "bookmarks"
    t.boolean  "level_zero"
    t.boolean  "level_nonzero"
    t.boolean  "today"
    t.boolean  "last_week"
    t.boolean  "last_month"
    t.boolean  "private"
    t.boolean  "public_viewing"
    t.boolean  "public_comments"
    t.boolean  "sort_by_votes"
    t.boolean  "sort_by_views"
    t.boolean  "has_parent"
    t.boolean  "has_no_parent"
    t.boolean  "last_year"
    t.boolean  "sort_by_updated_at"
    t.boolean  "sort_by_created_at"
    t.integer  "who_id"
    t.boolean  "lone_wolf"
    t.boolean  "descending"
  end

  create_table "followings", id: false, force: :cascade do |t|
    t.integer "prover_id"
    t.integer "following_id"
  end

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

  create_table "likes", force: :cascade do |t|
    t.integer "post_id"
    t.integer "prover_id"
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
    t.integer  "ranking"
    t.float    "highest_rating"
    t.datetime "highest_rating_date"
    t.boolean  "administrator"
    t.integer  "cur_filter"
    t.string   "profiletab"
    t.string   "kidtype"
  end

  add_index "provers", ["email"], name: "index_provers_on_email", unique: true, using: :btree
  add_index "provers", ["provername"], name: "index_provers_on_provername", unique: true, using: :btree
  add_index "provers", ["reset_password_token"], name: "index_provers_on_reset_password_token", unique: true, using: :btree

  create_table "siteconfigs", force: :cascade do |t|
    t.integer "post_id"
    t.string  "name"
    t.string  "stringvalue"
    t.integer "integervalue"
    t.float   "floatvalue"
  end

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
    t.boolean  "use_teams"
    t.integer  "prover_id"
  end

  create_table "users_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "prover_id"
  end

  add_foreign_key "bookmarks", "posts", column: "post"
  add_foreign_key "bookmarks", "provers", column: "owner"
  add_foreign_key "fallacies", "fallacyfolders", column: "folder"
  add_foreign_key "fallacyfolders", "fallacyfolders", column: "parent"
  add_foreign_key "filters", "provers"
  add_foreign_key "filters", "provers", column: "who_id"
  add_foreign_key "groups", "provers", column: "owner"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "provers"
  add_foreign_key "posts", "posts", column: "parent_id"
  add_foreign_key "posts", "provers"
  add_foreign_key "posts", "topics"
  add_foreign_key "provers", "filters", column: "cur_filter"
  add_foreign_key "teams", "provers"
  add_foreign_key "teams", "topics"
  add_foreign_key "topics", "provers"
  add_foreign_key "users_groups", "groups"
  add_foreign_key "users_groups", "provers"
end

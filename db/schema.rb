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

ActiveRecord::Schema.define(version: 20141217064029) do

  create_table "admin_forum_categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapters", force: true do |t|
    t.string   "title"
    t.integer  "story_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",      default: 0
  end

  create_table "favs", force: true do |t|
    t.integer "story_id"
    t.integer "user_id"
  end

  add_index "favs", ["user_id", "story_id"], name: "index_favs_on_user_id_and_story_id", unique: true, using: :btree

  create_table "forums", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "views",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
  end

  add_index "posts", ["forum_id"], name: "index_posts_on_forum_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "replies", force: true do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",   default: false
    t.integer  "views",       default: 0
  end

  add_index "stories", ["published"], name: "index_stories_on_published", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "context",    limit: 15
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     limit: 10, default: "pending"
  end

  create_table "taxonomies", force: true do |t|
    t.integer "tag_id"
    t.integer "story_id"
  end

  add_index "taxonomies", ["story_id", "tag_id"], name: "index_taxonomies_on_story_id_and_tag_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
    t.string   "role",            default: "user"
    t.integer  "post_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

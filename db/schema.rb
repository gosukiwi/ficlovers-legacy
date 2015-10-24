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

ActiveRecord::Schema.define(version: 20151024023801) do

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

  create_table "follows", force: true do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "follows", ["followable_id", "user_id"], name: "index_follows_on_followable_id_and_user_id", using: :btree

  create_table "forums", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0
  end

  create_table "groups", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.text     "message"
    t.boolean  "read"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notificable_id"
    t.string   "notificable_type"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "views",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.boolean  "pinned",     default: false
  end

  add_index "posts", ["forum_id"], name: "index_posts_on_forum_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "private_messages", force: true do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deleted_by",  default: 0
    t.string   "title"
  end

  add_index "private_messages", ["deleted_by"], name: "index_private_messages_on_deleted_by", using: :btree

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
    t.boolean  "published",        default: false
    t.integer  "views",            default: 0
    t.integer  "post_id"
    t.string   "thumb_url"
    t.datetime "thumb_expiration"
    t.integer  "language"
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
    t.string   "role",                       default: "user"
    t.integer  "post_count",                 default: 0
    t.string   "username",        limit: 25
    t.text     "about"
  end

  create_table "users_posts", force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "users_posts", ["post_id", "user_id"], name: "index_users_posts_on_post_id_and_user_id", unique: true, using: :btree

  create_table "wall_messages", force: true do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

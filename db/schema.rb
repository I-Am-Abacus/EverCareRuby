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

ActiveRecord::Schema.define(version: 20141122111435) do

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "public"
    t.integer  "status",     limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "follows", force: true do |t|
    t.integer  "cared_for_user_id"
    t.integer  "following_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_items", force: true do |t|
    t.integer  "user_id"
    t.integer  "carer_user_id"
    t.string   "narrative"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  add_index "news_items", ["id", "created_at"], name: "index_news_items_on_id_and_created_at"
  add_index "news_items", ["user_id"], name: "index_news_items_on_user_id"

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["remember_token"], name: "index_sessions_on_remember_token"
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",                           default: false
    t.integer  "status",                limit: 2
    t.integer  "current_account_id"
    t.integer  "age"
    t.string   "notes"
    t.string   "contact_details"
    t.string   "care_notes_collection"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

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

ActiveRecord::Schema.define(version: 20150331223143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "address"
    t.string   "home_tel"
    t.string   "mobile_tel"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "title"
    t.float    "balance"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "favourites", force: :cascade do |t|
    t.string   "stock_symbol"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "meeting_subject"
    t.datetime "meeting_date"
    t.string   "client_name"
    t.text     "meeting_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "memos", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "user_id"
  end

  add_index "memos", ["user_id"], name: "index_memos_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_salt"
    t.string   "password_hash"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "firstname"
    t.string   "surname"
    t.integer  "access_level",  default: 0
    t.string   "address"
  end

  create_table "watchlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favourite_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "watchlists", ["favourite_id"], name: "index_watchlists_on_favourite_id", using: :btree
  add_index "watchlists", ["user_id"], name: "index_watchlists_on_user_id", using: :btree

end

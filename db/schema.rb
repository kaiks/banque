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

ActiveRecord::Schema.define(version: 20160910160425) do

  create_table "accounts", force: :cascade do |t|
    t.string   "number",     limit: 11,               null: false
    t.integer  "bank_code",  limit: 3,                null: false
    t.integer  "sort_code",  limit: 3,                null: false
    t.integer  "rib_key",    limit: 1,                null: false
    t.integer  "status",                default: 0,   null: false
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "balance",               default: 0.0, null: false
  end

  add_index "accounts", ["number"], name: "index_accounts_on_number", unique: true
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "admins", force: :cascade do |t|
    t.string   "username",   limit: 20
    t.string   "name",       limit: 40
    t.string   "surname",    limit: 100
    t.string   "password",   limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "admins", ["username"], name: "index_admins_on_username", unique: true

  create_table "income_brackets", force: :cascade do |t|
    t.integer  "min",        null: false
    t.integer  "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "income_brackets", ["max"], name: "index_income_brackets_on_max", unique: true
  add_index "income_brackets", ["min"], name: "index_income_brackets_on_min", unique: true

  create_table "transactions", force: :cascade do |t|
    t.float    "amount",                       null: false
    t.integer  "transaction_type", default: 0, null: false
    t.integer  "status",           default: 0, null: false
    t.integer  "managed_by"
    t.datetime "managed_at"
    t.integer  "account_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id"

  create_table "users", force: :cascade do |t|
    t.integer  "title",             limit: 4,                  null: false
    t.string   "name",              limit: 40,                 null: false
    t.string   "surname",           limit: 80,                 null: false
    t.date     "birth_date",                                   null: false
    t.string   "city",              limit: 100,                null: false
    t.integer  "income_bracket_id",                            null: false
    t.string   "password",          limit: 100,                null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "country_code",      limit: 2,   default: "FR", null: false
  end

end

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

ActiveRecord::Schema.define(version: 20130420113639) do

  create_table "campaigns", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "starting_balance", default: 0
    t.string   "player_name"
    t.datetime "date",             default: '2000-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns_mission_packs", id: false, force: true do |t|
    t.integer "campaign_id"
    t.integer "mission_pack_id"
  end

  create_table "contracts", force: true do |t|
    t.integer  "institution_id"
    t.integer  "mission_id"
    t.integer  "campaign_id"
    t.integer  "reward"
    t.integer  "advance_percent", default: 0
    t.integer  "cost_plus_limit", default: -1
    t.integer  "penalty"
    t.integer  "time_limit"
    t.string   "status",          default: "open"
    t.datetime "issued_at"
    t.datetime "completed_at"
    t.datetime "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "contract_id"
    t.integer  "ship_cost"
    t.string   "name"
    t.string   "status",      default: "started"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "time_modifier",      default: 1.0
    t.float    "penalty_modifier",   default: 1.0
    t.float    "reward_modifier",    default: 1.0
    t.integer  "initial_reputation", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mission_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mission_packs", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "mods",        default: ""
    t.text     "description", default: ""
    t.boolean  "official",    default: false
    t.boolean  "public",      default: true
    t.boolean  "deleted",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: true do |t|
    t.integer  "mission_category_id"
    t.integer  "mission_pack_id"
    t.string   "name"
    t.text     "description"
    t.integer  "minimum_balance",     default: 0
    t.boolean  "repeatable",          default: false
    t.boolean  "institution_only",    default: false
    t.boolean  "deleted",             default: false
    t.integer  "reward"
    t.integer  "minimal_time"
    t.integer  "maximal_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reputations", force: true do |t|
    t.integer  "institution_id"
    t.integer  "campaign_id"
    t.integer  "contract_id"
    t.integer  "change",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "campaign_id"
    t.integer  "flight_id"
    t.integer  "contract_id"
    t.integer  "amount"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

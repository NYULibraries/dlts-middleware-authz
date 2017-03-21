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

ActiveRecord::Schema.define(version: 20170321171136) do

  create_table "api_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "api_key_public"
    t.string   "api_key_hash"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "auth_ip_address_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auth_ip_address_groups_addresses", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "auth_ip_address_group_id", null: false
    t.integer "auth_ip_address_id",       null: false
  end

  create_table "auth_ip_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.bigint   "ipv4_address"
    t.binary   "ipv6_address", limit: 16
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "auth_ip_addresses_items", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "item_id",            null: false
    t.integer "auth_ip_address_id", null: false
  end

  create_table "auth_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_auth_services_on_name", unique: true, using: :btree
  end

  create_table "auth_services_items", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "item_id",         null: false
    t.integer "auth_service_id", null: false
  end

  create_table "end_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_end_services_on_name", unique: true, using: :btree
    t.index ["uri"], name: "index_end_services_on_uri", unique: true, using: :btree
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "handle",         limit: 17
    t.integer  "end_service_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "uri_extra"
    t.index ["end_service_id"], name: "index_items_on_end_service_id", using: :btree
    t.index ["handle"], name: "index_items_on_handle", unique: true, using: :btree
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token"
    t.json     "oauth_response"
    t.datetime "expires_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["token"], name: "index_sessions_on_token", unique: true, using: :btree
  end

  add_foreign_key "items", "end_services"
end

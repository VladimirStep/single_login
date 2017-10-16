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

ActiveRecord::Schema.define(version: 20171016120050) do

  create_table "granted_accesses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "website_id"
    t.string "code"
    t.string "state"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_token"
    t.datetime "access_token_expires_at"
    t.index ["access_token"], name: "index_granted_accesses_on_access_token"
    t.index ["code"], name: "index_granted_accesses_on_code"
    t.index ["refresh_token"], name: "index_granted_accesses_on_refresh_token"
    t.index ["user_id"], name: "index_granted_accesses_on_user_id"
    t.index ["website_id"], name: "index_granted_accesses_on_website_id"
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.datetime "birth_date"
    t.string "street"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["token"], name: "index_users_on_token"
  end

  create_table "websites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "domain_name"
    t.string "secrete_id"
    t.string "secrete_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secrete_id"], name: "index_websites_on_secrete_id"
    t.index ["user_id"], name: "index_websites_on_user_id"
  end

  add_foreign_key "granted_accesses", "users"
  add_foreign_key "granted_accesses", "websites"
  add_foreign_key "profiles", "users"
  add_foreign_key "websites", "users"
end

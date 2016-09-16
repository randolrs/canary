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

ActiveRecord::Schema.define(version: 20160916150901) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exhibitions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "city_id"
    t.string   "venue_name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "state_or_province"
    t.string   "zip_or_postal_code"
    t.string   "country"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "city"
  end

  create_table "item_arts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "name"
    t.decimal  "height"
    t.decimal  "width"
    t.decimal  "length"
    t.integer  "venue_id"
    t.decimal  "price"
    t.string   "search_code"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "exhibit_id"
    t.string   "medium",             default: ""
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "recipient_id"
    t.string   "subject",           default: "(No subject)"
    t.text     "body"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "parent_message_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.string   "status"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.string   "card_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "amount"
    t.string   "description"
    t.integer  "item_art_id"
    t.string   "currency"
    t.string   "stripe_customer_id"
    t.string   "stripe_card_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "onboarded",              default: false
    t.boolean  "is_artist",              default: false
    t.boolean  "is_buyer",               default: false
    t.integer  "home_city_id"
    t.string   "display_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "about",                  default: ""
    t.string   "stripe_account_id"
    t.string   "stripe_secret_key"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "views", force: :cascade do |t|
    t.integer  "item_art_id"
    t.string   "visitor_ip"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end

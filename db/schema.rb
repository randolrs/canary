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

ActiveRecord::Schema.define(version: 20161024220843) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collection_items", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.integer  "item_art_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "gallery_submission_id"
  end

  create_table "collections", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "gallery_submission_id"
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

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "number_of_images"
    t.boolean  "include_artist_statement"
    t.boolean  "require_additional_description"
  end

  create_table "gallery_submission_formats", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "number_of_images"
    t.boolean  "include_artist_statement"
    t.boolean  "require_additional_description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "gallery_submissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gallery_id"
    t.integer  "collection_id"
    t.text     "additional_description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "paid"
    t.decimal  "cost"
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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "exhibit_id"
    t.string   "medium",              default: ""
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_sample"
    t.boolean  "is_visible"
    t.text     "pickup_instructions"
    t.string   "sample_name"
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "use_default_card"
    t.string   "contact_email"
    t.string   "contact_full_name"
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
    t.integer  "order_id"
    t.string   "ip_address"
  end

  create_table "stripe_billing_user_subscriptions", force: :cascade do |t|
    t.integer  "stripe_customer_id"
    t.integer  "user_id"
    t.integer  "stripe_plan_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "plan_id"
    t.boolean  "active"
  end

  create_table "stripe_user_customers", force: :cascade do |t|
    t.string   "user_id"
    t.string   "stripe_customer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer  "gallery_id"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "stripe_customer_id"
    t.boolean  "is_admin"
    t.boolean  "billing_initiated"
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

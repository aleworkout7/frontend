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

ActiveRecord::Schema.define(version: 20180217042016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "predio_id"
    t.string   "number"
    t.string   "block"
    t.integer  "floor"
    t.string   "complement"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["predio_id"], name: "index_addresses_on_predio_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "alejandros", force: :cascade do |t|
    t.string   "email"
    t.integer  "payment"
    t.date     "payment_date"
    t.date     "due_date"
    t.text     "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "member_id"
  end

  create_table "bancos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mercado_pago_notifications", force: :cascade do |t|
    t.string   "transaction_id"
    t.integer  "payer_id"
    t.integer  "collector_id"
    t.integer  "application_id"
    t.string   "status"
    t.string   "external_reference"
    t.datetime "date_created"
    t.datetime "last_modified"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.text     "observation"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "order_statuses", ["order_id"], name: "index_order_statuses_on_order_id", using: :btree
  add_index "order_statuses", ["user_id"], name: "index_order_statuses_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.text     "observation"
    t.integer  "total"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "money_exchange"
  end

  add_index "orders", ["shop_id"], name: "index_orders_on_shop_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pagos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "member_id"
    t.date     "payment_date"
    t.integer  "amount"
    t.text     "message"
    t.boolean  "checked"
    t.string   "predio_name"
    t.text     "predio_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "email"
    t.date     "notice_date"
    t.integer  "banco_id"
    t.string   "account_number"
    t.integer  "account_id"
    t.string   "image"
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.string   "transaction_id"
    t.integer  "payer_id",             limit: 8
    t.string   "status"
    t.string   "external_reference"
    t.float    "total_paid_amount"
    t.string   "payment_type"
    t.string   "payment_method_id"
    t.integer  "transaction_order_id", limit: 8
    t.datetime "date_created"
    t.datetime "date_approved"
    t.datetime "money_release_date"
    t.datetime "last_modified"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "predios", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.text     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.text     "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "shop_id"
    t.integer  "user_id"
    t.string   "image"
  end

  create_table "queries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.text     "greeting"
    t.string   "number"
    t.boolean  "whatsapp"
    t.boolean  "phone"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image"
    t.boolean  "available",   default: true
    t.integer  "category_id"
    t.integer  "predio_id"
  end

  create_table "subscription_notifications", force: :cascade do |t|
    t.string   "transaction_id"
    t.integer  "payer_id",           limit: 8
    t.integer  "collector_id",       limit: 8
    t.integer  "application_id",     limit: 8
    t.string   "status"
    t.string   "external_reference"
    t.datetime "date_created"
    t.datetime "last_modified"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "admin",                   default: false
    t.boolean  "actived",                 default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "name"
    t.string   "phone"
    t.boolean  "had_subscription_before"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "predios"
  add_foreign_key "addresses", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_statuses", "orders"
  add_foreign_key "order_statuses", "users"
  add_foreign_key "orders", "shops"
  add_foreign_key "orders", "users"
end

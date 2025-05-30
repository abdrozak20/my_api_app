# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_23_164058) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "category_code"
    t.string "name"
    t.string "size"
    t.integer "stock"
    t.string "unit"
    t.text "description"
    t.decimal "purchase_price"
    t.string "image_path"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "categories_unique", unique: true
  end

  create_table "transaction_items", force: :cascade do |t|
    t.string "transaction_code"
    t.string "product_code"
    t.integer "qty", default: 0
    t.decimal "price"
    t.text "notes"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_code"], name: "product_item_code_idx"
    t.index ["transaction_code"], name: "transaction_item_code_idx"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_code"
    t.string "transaction_type", limit: 10
    t.string "customer_name"
    t.string "supplier_name"
    t.text "notes"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_code"], name: "transaction_code_unique", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refresh_token"
  end
end

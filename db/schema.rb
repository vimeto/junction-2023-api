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

ActiveRecord::Schema[7.1].define(version: 2023_11_11_094246) do
  create_table "addresses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_companies_on_address_id"
  end

  create_table "company_contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_contacts_on_company_id"
  end

  create_table "heating_units", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "heating_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heatings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "energy", precision: 10
    t.decimal "cost", precision: 10
    t.string "state"
    t.decimal "percentage", precision: 10
    t.bigint "heating_unit_id", null: false
    t.bigint "query_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["heating_unit_id"], name: "index_heatings_on_heating_unit_id"
    t.index ["query_id"], name: "index_heatings_on_query_id"
  end

  create_table "queries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.string "name"
    t.decimal "budget", precision: 10
    t.bigint "address_id", null: false
    t.integer "occupants"
    t.datetime "due_date"
    t.text "summary"
    t.decimal "houseSqm", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_queries_on_address_id"
    t.index ["user_id"], name: "index_queries_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "addresses"
  add_foreign_key "company_contacts", "companies"
  add_foreign_key "heatings", "heating_units"
  add_foreign_key "heatings", "queries"
  add_foreign_key "queries", "addresses"
  add_foreign_key "queries", "users"
end

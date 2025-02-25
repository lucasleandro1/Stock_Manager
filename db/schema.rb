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

ActiveRecord::Schema[8.0].define(version: 2025_02_25_130854) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "cpf_cnpj"
    t.string "phone"
    t.string "email"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "nota_fiscals", force: :cascade do |t|
    t.integer "stock_movement_id", null: false
    t.string "cnpj"
    t.string "razao_social"
    t.string "documento"
    t.string "nome"
    t.string "codigo"
    t.string "nome_produto"
    t.integer "quantidade"
    t.decimal "valor_unitario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_movement_id"], name: "index_nota_fiscals_on_stock_movement_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "stock_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sku"
    t.integer "user_id"
    t.integer "category_id"
    t.integer "nota_fiscal_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["nota_fiscal_id"], name: "index_products_on_nota_fiscal_id"
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

  create_table "stock_movement_items", force: :cascade do |t|
    t.integer "stock_movement_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_movement_items_on_product_id"
    t.index ["stock_movement_id"], name: "index_stock_movement_items_on_stock_movement_id"
  end

  create_table "stock_movement_products", force: :cascade do |t|
    t.integer "stock_movement_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_movement_products_on_product_id"
    t.index ["stock_movement_id"], name: "index_stock_movement_products_on_stock_movement_id"
  end

  create_table "stock_movements", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "quantity"
    t.integer "movement_type"
    t.integer "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "price"
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_stock_movements_on_customer_id"
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
    t.index ["user_id"], name: "index_stock_movements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "business_name"
    t.string "cnpj"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "nota_fiscals", "stock_movements"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "nota_fiscals"
  add_foreign_key "stock_movement_items", "products"
  add_foreign_key "stock_movement_items", "stock_movements"
  add_foreign_key "stock_movement_products", "products"
  add_foreign_key "stock_movement_products", "stock_movements"
  add_foreign_key "stock_movements", "customers"
  add_foreign_key "stock_movements", "products"
  add_foreign_key "stock_movements", "users"
end

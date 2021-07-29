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

ActiveRecord::Schema.define(version: 2021_07_29_030759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "nombre_categoria"
    t.string "descripcion_categoria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "rif_cliente"
    t.string "nombre_cliente"
    t.string "correo_cliente"
    t.string "descripcion_cliente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "type_client_id"
    t.string "direccion_cliente"
    t.index ["type_client_id"], name: "index_clients_on_type_client_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "rif_empresa"
    t.string "nombre_empresa"
    t.string "direccion_empresa"
    t.integer "telefono_empresa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "numero_control"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "numero_cedula"
    t.string "primer_nombre"
    t.string "segundo_nombre"
    t.string "primer_apellido"
    t.string "segundo_apellido"
    t.date "fecha_ingreso"
    t.string "correo_empleado"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "position_id"
    t.decimal "salario_empleado"
    t.string "direccion_empleado"
    t.index ["position_id"], name: "index_employees_on_position_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "nombre_lugar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paycheck_types", force: :cascade do |t|
    t.string "tipo_nomina_nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paychecks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "employee_id"
    t.bigint "paycheck_type_id"
    t.decimal "salario_nomina"
    t.date "inicio_nomina"
    t.date "fin_nomina"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "dias_nomina"
    t.decimal "alimento_cesta"
    t.decimal "adelanto_nomina"
    t.decimal "salario_empleado"
    t.bigint "type_payment_id"
    t.index ["employee_id"], name: "index_paychecks_on_employee_id"
    t.index ["paycheck_type_id"], name: "index_paychecks_on_paycheck_type_id"
    t.index ["type_payment_id"], name: "index_paychecks_on_type_payment_id"
    t.index ["user_id"], name: "index_paychecks_on_user_id"
  end

  create_table "phoneclients", force: :cascade do |t|
    t.bigint "client_id"
    t.string "numero_cliente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phoneclients_on_client_id"
  end

  create_table "phoneployees", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "numero_empleado"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_phoneployees_on_employee_id"
  end

  create_table "phonesuppliers", force: :cascade do |t|
    t.bigint "supplier_id"
    t.string "numero_proveedor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_phonesuppliers_on_supplier_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "nombre_cargo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "codigo_producto"
    t.string "nombre_producto"
    t.integer "existencia_producto"
    t.string "descripcion_producto"
    t.decimal "precio_producto"
    t.integer "min_producto"
    t.boolean "condicion_producto"
    t.bigint "category_id", null: false
    t.bigint "unit_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["location_id"], name: "index_products_on_location_id"
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer "cantidad"
    t.decimal "precio_detalle_compra"
    t.bigint "product_id"
    t.bigint "purchase_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_purchase_details_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_details_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "numero_compra"
    t.decimal "total_compra"
    t.integer "user_id"
    t.bigint "supplier_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "type_payment_id"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
    t.index ["type_payment_id"], name: "index_purchases_on_type_payment_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "nombre_rol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sale_details", force: :cascade do |t|
    t.integer "cantidad"
    t.decimal "precio_detalle_venta"
    t.bigint "product_id"
    t.bigint "sale_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_sale_details_on_product_id"
    t.index ["sale_id"], name: "index_sale_details_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "numero_venta"
    t.decimal "total_venta"
    t.integer "user_id"
    t.bigint "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "type_payment_id"
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["type_payment_id"], name: "index_sales_on_type_payment_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "rif_proveedor"
    t.string "nombre_proveedor"
    t.string "correo_proveedor"
    t.string "descripcion_proveedor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "direccion_proveedor"
  end

  create_table "type_clients", force: :cascade do |t|
    t.string "nombre_tipo_cliente"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "type_payments", force: :cascade do |t|
    t.string "nombre_tipo_pago"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "nombre_unidad"
    t.string "simbolo_unidad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", default: "", null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "paychecks", "employees"
  add_foreign_key "paychecks", "paycheck_types"
  add_foreign_key "paychecks", "type_payments"
  add_foreign_key "paychecks", "users"
  add_foreign_key "phoneclients", "clients"
  add_foreign_key "phoneployees", "employees"
  add_foreign_key "phonesuppliers", "suppliers"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "locations"
  add_foreign_key "products", "units"
  add_foreign_key "purchase_details", "products"
  add_foreign_key "purchase_details", "purchases"
  add_foreign_key "purchases", "suppliers"
  add_foreign_key "purchases", "type_payments"
  add_foreign_key "sale_details", "products"
  add_foreign_key "sale_details", "sales"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "type_payments"
  add_foreign_key "users", "roles"
end

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

ActiveRecord::Schema[7.0].define(version: 2022_11_25_162628) do
  create_table "clientes", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "email", default: "", null: false
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_clientes_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clientes_on_reset_password_token", unique: true
  end

  create_table "dias", force: :cascade do |t|
    t.integer "dia"
    t.integer "inicio"
    t.integer "fin"
    t.integer "sucursal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sucursal_id"], name: "index_dias_on_sucursal_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "sucursales", force: :cascade do |t|
    t.string "nombre"
    t.string "direccion"
    t.integer "telefono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turnos", force: :cascade do |t|
    t.string "motivo"
    t.datetime "fecha"
    t.string "estado"
    t.string "resultado"
    t.integer "usuario_id"
    t.integer "cliente_id"
    t.integer "sucursal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_turnos_on_cliente_id"
    t.index ["sucursal_id"], name: "index_turnos_on_sucursal_id"
    t.index ["usuario_id"], name: "index_turnos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "email", default: "", null: false
    t.string "password"
    t.integer "sucursal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["sucursal_id"], name: "index_usuarios_on_sucursal_id"
  end

  create_table "usuarios_roles", id: false, force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_usuarios_roles_on_role_id"
    t.index ["usuario_id", "role_id"], name: "index_usuarios_roles_on_usuario_id_and_role_id"
    t.index ["usuario_id"], name: "index_usuarios_roles_on_usuario_id"
  end

end

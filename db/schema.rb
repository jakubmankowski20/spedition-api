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

ActiveRecord::Schema.define(version: 20171128140052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "auth_user_components", id: false, force: :cascade do |t|
    t.integer "auth_user_role_id", null: false
    t.integer "component_id", null: false
    t.integer "is_visible", null: false
    t.index ["auth_user_role_id"], name: "auth_user_component_i01"
    t.index ["component_id"], name: "auth_user_component_i02"
  end

  create_table "auth_user_licences", id: false, force: :cascade do |t|
    t.integer "auth_user_id"
    t.integer "licence_id"
  end

  create_table "auth_user_roles", id: :serial, force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
    t.integer "is_enabled"
    t.index ["code"], name: "auth_user_role_i01"
    t.index ["code"], name: "auth_user_role_u01", unique: true
    t.index ["id"], name: "auth_user_role_ipk"
    t.index ["name"], name: "auth_user_role_i02"
  end

  create_table "auth_users", id: :serial, force: :cascade do |t|
    t.integer "role_id", default: 1, null: false
    t.string "login", limit: 255, null: false
    t.string "password", limit: 255, null: false
    t.datetime "created_at"
    t.string "name", limit: 255, null: false
    t.string "surname", limit: 255, null: false
    t.string "email", limit: 255
    t.string "phone_number", limit: 255
    t.index ["email"], name: "auth_user_i05", unique: true
    t.index ["email"], name: "auth_user_u02", unique: true
    t.index ["id"], name: "auth_user_ipk"
    t.index ["login"], name: "auth_user_i01"
    t.index ["login"], name: "auth_user_u01", unique: true
    t.index ["password"], name: "auth_user_i02"
    t.index ["phone_number"], name: "auth_user_i06"
    t.index ["surname", "name"], name: "auth_user_i03"
    t.index ["surname"], name: "auth_user_i04"
  end

  create_table "components", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.integer "default_visible"
    t.index ["code"], name: "component_i02"
    t.index ["code"], name: "component_u01", unique: true
    t.index ["id"], name: "component_ipk"
    t.index ["name"], name: "component_i01"
  end

  create_table "licences", id: :serial, force: :cascade do |t|
    t.integer "name"
    t.date "end_time"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "short_name", limit: 255
    t.string "country", limit: 255
    t.string "city", limit: 255
    t.string "street", limit: 255
    t.string "building_no", limit: 255
    t.float "latitude"
    t.float "longitude"
  end

  create_table "order_change_status_history", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "status_transition_id"
    t.datetime "change_time"
  end

  create_table "order_priorities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255, null: false
    t.integer "value", null: false
    t.index ["code"], name: "order_priority_i01"
    t.index ["code"], name: "order_priority_u01", unique: true
    t.index ["id"], name: "order_priority_ipk", unique: true
    t.index ["value"], name: "order_priority_i02"
    t.index ["value"], name: "order_priority_u02", unique: true
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "start_location_id", null: false
    t.integer "finish_location_id", null: false
    t.datetime "create_at", null: false
    t.datetime "start_date", null: false
    t.datetime "finish_date"
    t.integer "create_user_id", null: false
    t.integer "status_id", null: false
    t.integer "assigned_to_user_id"
    t.string "description", limit: 4000
    t.integer "priority_id", null: false
    t.datetime "avaliable_from"
    t.datetime "aviable_to"
    t.integer "vehicle_id"
    t.integer "ware_id"
    t.index ["assigned_to_user_id"], name: "order_i08"
    t.index ["create_at"], name: "order_i03"
    t.index ["create_user_id"], name: "order_i06"
    t.index ["finish_date"], name: "order_i05"
    t.index ["finish_location_id"], name: "order_i02"
    t.index ["id"], name: "order_ipk", unique: true
    t.index ["priority_id"], name: "order_i09"
    t.index ["start_date"], name: "order_i04"
    t.index ["start_location_id"], name: "order_i01"
    t.index ["status_id"], name: "order_i07"
  end

  create_table "privileges", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.index ["code"], name: "privelege_i01"
    t.index ["code"], name: "privelege_u01", unique: true
    t.index ["id"], name: "privelege_ipk"
  end

  create_table "status_transitions", id: :serial, force: :cascade do |t|
    t.integer "status_from_id"
    t.integer "status_to_id"
  end

  create_table "statuses", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
  end

  create_table "vehicles", id: :serial, force: :cascade do |t|
    t.string "truck_brand", limit: 255
    t.string "registration_number", limit: 255
    t.float "max_load"
    t.date "produce_year"
    t.date "next_review"
    t.index ["registration_number"], name: "vehicle_u01", unique: true
  end

  create_table "ware_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "type", limit: 255
    t.integer "licence_required"
    t.index ["type"], name: "ware_type_u01", unique: true
  end

  create_table "wares", id: :serial, force: :cascade do |t|
    t.integer "ware_type_id"
    t.float "mass"
  end

  add_foreign_key "auth_user_components", "auth_user_roles", name: "auth_user_component_r01"
  add_foreign_key "auth_user_components", "components", name: "auth_user_component_r02"
  add_foreign_key "auth_user_licences", "licences", name: "auth_user_licence_r01"
  add_foreign_key "auth_users", "auth_user_roles", column: "role_id", name: "auth_user_r01"
  add_foreign_key "order_change_status_history", "orders", name: "order_change_history_r01"
  add_foreign_key "order_change_status_history", "status_transitions", name: "order_change_history_r02"
  add_foreign_key "orders", "auth_users", column: "create_user_id", name: "order_pk01"
  add_foreign_key "orders", "locations", column: "finish_location_id", name: "order_r03"
  add_foreign_key "orders", "locations", column: "start_location_id", name: "order_r02"
  add_foreign_key "orders", "order_priorities", column: "priority_id", name: "order_r01"
  add_foreign_key "orders", "statuses", name: "order_r06"
  add_foreign_key "orders", "vehicles", name: "order_r04"
  add_foreign_key "orders", "wares", name: "order_r05"
  add_foreign_key "status_transitions", "statuses", column: "status_from_id", name: "status_transition_r01"
  add_foreign_key "status_transitions", "statuses", column: "status_to_id", name: "status_transition_r02"
  add_foreign_key "wares", "ware_types", name: "ware_r01"
end

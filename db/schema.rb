ActiveRecord::Schema.define(version: 2023_08_01_065102) do
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sex", default: 1, null: false
    t.integer "age", null: false
    t.integer "diet", default: 1, null: false
    t.boolean "pet", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_families_on_user_id"
  end

  create_table "maps", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_maps_on_user_id"
  end

  create_table "stockpiles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "expiry_on"
    t.datetime "notice_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.boolean "status", default: false
    t.index ["user_id"], name: "index_stockpiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "families", "users"
  add_foreign_key "maps", "users"
  add_foreign_key "stockpiles", "users"
end

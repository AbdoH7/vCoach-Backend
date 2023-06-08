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

ActiveRecord::Schema[7.0].define(version: 2023_06_08_223138) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctor_patient_assignments", force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "patient_id"], name: "index_doctor_patient_assignments_on_doctor_id_and_patient_id", unique: true
    t.check_constraint "doctor_id IS NOT NULL AND is_type_doctor(doctor_id)", name: "ck_doctor_patient_assignments_doctor"
    t.check_constraint "patient_id IS NOT NULL AND is_type_patient(patient_id)", name: "ck_doctor_patient_assignments_patient"
  end

  create_table "invites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "email", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false, null: false
    t.check_constraint "user_id IS NOT NULL AND is_doctor(user_id)", name: "ck_user_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "user_type"
    t.datetime "DOB"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
  end

  add_foreign_key "doctor_patient_assignments", "users", column: "doctor_id", on_delete: :nullify
  add_foreign_key "doctor_patient_assignments", "users", column: "patient_id", on_delete: :nullify
  add_foreign_key "invites", "users", on_delete: :nullify
end

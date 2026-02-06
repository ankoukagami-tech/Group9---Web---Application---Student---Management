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

ActiveRecord::Schema[8.1].define(version: 2026_02_06_140929) do
  create_table "courses", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.integer "credits"
    t.text "description"
    t.integer "max_capacity"
    t.string "semester"
    t.integer "teacher_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["code"], name: "index_courses_on_code", unique: true
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "enrollment_date"
    t.decimal "grade"
    t.string "status", default: "enrolled"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id", "course_id"], name: "index_enrollments_on_student_id_and_course_id", unique: true
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "emergency_contact"
    t.date "enrollment_date"
    t.string "first_name", null: false
    t.string "gender"
    t.string "last_name", null: false
    t.string "phone"
    t.string "status", default: "active"
    t.string "student_number", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["student_number"], name: "index_students_on_student_number", unique: true
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "department"
    t.string "employee_number", null: false
    t.string "first_name", null: false
    t.date "hire_date"
    t.string "last_name", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["employee_number"], name: "index_teachers_on_employee_number", unique: true
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role_id", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "courses", "teachers"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "students", "users"
  add_foreign_key "teachers", "users"
  add_foreign_key "users", "roles"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_25_110504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colleges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "semester"
    t.integer "credits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses_specialities", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "speciality_id"
    t.index ["course_id"], name: "index_courses_specialities_on_course_id"
    t.index ["speciality_id"], name: "index_courses_specialities_on_speciality_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.bigint "college_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["college_id"], name: "index_faculties_on_college_id"
  end

  create_table "faculties_professors", id: false, force: :cascade do |t|
    t.bigint "faculty_id"
    t.bigint "professor_id"
    t.index ["faculty_id"], name: "index_faculties_professors_on_faculty_id"
    t.index ["professor_id"], name: "index_faculties_professors_on_professor_id"
  end

  create_table "professors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "specialities", force: :cascade do |t|
    t.bigint "faculty_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_specialities_on_faculty_id"
  end

  create_table "timeblocks", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "day"
    t.string "session_type"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "professor_id", null: false
    t.index ["professor_id"], name: "index_timeblocks_on_professor_id"
    t.index ["section_id"], name: "index_timeblocks_on_section_id"
  end

  add_foreign_key "faculties", "colleges"
  add_foreign_key "sections", "courses"
  add_foreign_key "specialities", "faculties"
  add_foreign_key "timeblocks", "professors"
  add_foreign_key "timeblocks", "sections"
end

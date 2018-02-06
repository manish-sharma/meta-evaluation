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

ActiveRecord::Schema.define(version: 20180206040308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grading_scales", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "grade_scale_steps"
    t.boolean "is_for_result"
    t.string "academic_year_structure_id"
    t.integer "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_year_structure_id", "name"], name: "index_grading_scales_on_academic_year_structure_id_and_name", unique: true
    t.index ["organization_id"], name: "index_grading_scales_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "domain_name", null: false
    t.integer "organization_type", null: false
    t.string "access_key"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_key"], name: "index_organizations_on_access_key"
    t.index ["created_by"], name: "index_organizations_on_created_by"
    t.index ["domain_name"], name: "index_organizations_on_domain_name"
    t.index ["name"], name: "index_organizations_on_name"
    t.index ["organization_type"], name: "index_organizations_on_organization_type"
    t.index ["updated_by"], name: "index_organizations_on_updated_by"
  end

end

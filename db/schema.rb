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

ActiveRecord::Schema.define(version: 20180220072829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "evaluation_components", force: :cascade do |t|
    t.string "name"
    t.integer "component_structure"
    t.integer "calculation_method", default: 0
    t.integer "sequence"
    t.string "remarks"
    t.string "code"
    t.boolean "is_active"
    t.bigint "parent_evaluation_component_id"
    t.bigint "evaluation_scheme_id"
    t.bigint "academic_year_id"
    t.datetime "deleted_at"
    t.integer "organization_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_evaluation_components_on_created_by"
    t.index ["evaluation_scheme_id"], name: "index_evaluation_components_on_evaluation_scheme_id"
    t.index ["organization_id"], name: "index_evaluation_components_on_organization_id"
    t.index ["parent_evaluation_component_id"], name: "index_evaluation_components_on_parent_evaluation_component_id"
    t.index ["updated_by"], name: "index_evaluation_components_on_updated_by"
  end

  create_table "evaluation_schemes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "scheme_type"
    t.boolean "is_active", default: false
    t.integer "term_count"
    t.integer "stage_count"
    t.integer "event_marks_decimal_places", default: 2
    t.integer "event_scaled_marks_decimal_places", default: 2
    t.integer "stage_marks_decimal_places", default: 2
    t.integer "sub_event_marks_decimal_places", default: 2
    t.integer "absentee_aggregation_rule"
    t.boolean "is_practical", default: false
    t.bigint "department_id"
    t.bigint "academic_year_id"
    t.datetime "deleted_at"
    t.bigint "grading_scale_id"
    t.integer "organization_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_evaluation_schemes_on_created_by"
    t.index ["grading_scale_id"], name: "index_evaluation_schemes_on_grading_scale_id"
    t.index ["is_active"], name: "index_evaluation_schemes_on_is_active"
    t.index ["name"], name: "index_evaluation_schemes_on_name"
    t.index ["organization_id"], name: "index_evaluation_schemes_on_organization_id"
    t.index ["scheme_type"], name: "index_evaluation_schemes_on_scheme_type"
    t.index ["updated_by"], name: "index_evaluation_schemes_on_updated_by"
  end

  create_table "evaluation_stages", force: :cascade do |t|
    t.string "name"
    t.integer "sequence"
    t.bigint "evaluation_term_id"
    t.datetime "deleted_at"
    t.bigint "academic_year_id"
    t.integer "organization_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_evaluation_stages_on_created_by"
    t.index ["evaluation_term_id"], name: "index_evaluation_stages_on_evaluation_term_id"
    t.index ["organization_id"], name: "index_evaluation_stages_on_organization_id"
    t.index ["updated_by"], name: "index_evaluation_stages_on_updated_by"
  end

  create_table "evaluation_terms", force: :cascade do |t|
    t.string "name"
    t.integer "sequence"
    t.boolean "is_active", default: false
    t.bigint "evaluation_scheme_id"
    t.bigint "academic_year_id"
    t.datetime "deleted_at"
    t.integer "organization_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_evaluation_terms_on_created_by"
    t.index ["evaluation_scheme_id"], name: "index_evaluation_terms_on_evaluation_scheme_id"
    t.index ["organization_id"], name: "index_evaluation_terms_on_organization_id"
    t.index ["updated_by"], name: "index_evaluation_terms_on_updated_by"
  end

  create_table "grading_scale_steps", force: :cascade do |t|
    t.decimal "maximum"
    t.decimal "minimum"
    t.integer "numeric_display"
    t.string "step_display"
    t.integer "step_weight"
    t.datetime "deleted_at"
    t.integer "organization_id"
    t.bigint "grading_scale_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_grading_scale_steps_on_created_by"
    t.index ["grading_scale_id"], name: "index_grading_scale_steps_on_grading_scale_id"
    t.index ["organization_id"], name: "index_grading_scale_steps_on_organization_id"
    t.index ["updated_by"], name: "index_grading_scale_steps_on_updated_by"
  end

  create_table "grading_scales", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "grade_scale_steps"
    t.boolean "is_for_result", default: false
    t.datetime "deleted_at"
    t.integer "organization_id"
    t.string "created_by", null: false
    t.string "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_grading_scales_on_created_by"
    t.index ["name"], name: "index_grading_scales_on_name", unique: true
    t.index ["organization_id"], name: "index_grading_scales_on_organization_id"
    t.index ["updated_by"], name: "index_grading_scales_on_updated_by"
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

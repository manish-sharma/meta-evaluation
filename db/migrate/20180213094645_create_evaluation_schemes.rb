class CreateEvaluationSchemes < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_schemes do |t|
      t.string :name, index: true, null: false
      t.integer :scheme_type, index: true
      t.boolean :is_active, index: true, default: false
      t.integer :term_count
      t.integer :stage_count
      t.integer :event_marks_decimal_places, default: 2
      t.integer :event_scaled_marks_decimal_places, default: 2
      t.integer :stage_marks_decimal_places, default: 2
      t.integer :sub_event_marks_decimal_places, default: 2
      t.integer :absentee_aggregation_rule
      t.boolean :is_practical, default: false
      t.bigint :department_id
      t.bigint :academic_year_id
      t.datetime :deleted_at
      t.references :grading_scale
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

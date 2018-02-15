class CreateGradingScaleSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_scale_steps do |t|
      t.decimal :maximum
      t.decimal :minimum
      t.integer :numeric_display
      t.string :step_display
      t.integer :step_weight
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.references :grading_scale
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

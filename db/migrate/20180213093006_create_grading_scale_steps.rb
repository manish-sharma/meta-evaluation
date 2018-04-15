class CreateGradingScaleSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_scale_steps do |t|
      t.decimal :maximum
      t.decimal :minimum
      t.integer :numeric_display
      t.string :step_display_name
      t.integer :color
      t.integer :result
      t.integer :step_weight
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.references :grading_scale, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
    add_index :grading_scale_steps, [:maximum,:minimum,:numeric_display,:step_display_name,:step_weight,:deleted_at,:organization_id], unique: true, name: 'uniqueness_index'
  end
end

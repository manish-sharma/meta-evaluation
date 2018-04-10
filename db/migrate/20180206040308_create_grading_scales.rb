class CreateGradingScales < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_scales do |t|
      t.string :name
      t.text :description
      t.integer :grade_scale_steps
      t.boolean :is_for_result, default: false
      t.datetime :deleted_at
      t.integer :lock_version
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end

    add_index :grading_scales, [:name,:organization_id,:deleted_at], unique: true
  end
end

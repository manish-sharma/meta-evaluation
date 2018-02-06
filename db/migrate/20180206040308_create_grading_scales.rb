class CreateGradingScales < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_scales do |t|
      t.string :name
      t.text :description
      t.integer :grade_scale_steps
      t.boolean :is_for_result
      t.string :academic_year_structure_id
      t.integer :organization_id, index: true


      t.timestamps
    end

    add_index :grading_scales, [:academic_year_structure_id, :name], unique: true
  end
end

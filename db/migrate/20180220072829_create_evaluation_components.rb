class CreateEvaluationComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_components do |t|
      t.string :name
      t.integer :component_structure
      t.integer :calculation_method, default: 0
      t.integer :sequence
      t.string :remarks
      t.string :code
      t.boolean :is_active
      t.references :parent_evaluation_component
      t.references :evaluation_scheme
      t.bigint :academic_year_id
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

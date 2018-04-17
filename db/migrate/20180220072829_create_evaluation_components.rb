class CreateEvaluationComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_components do |t|
      t.string :name
      t.string :type
      t.integer :calculation_method, default: 0
      t.integer :evaluation_group, default: 0
      t.integer :category, default: 0
      t.string :report_card_name
      t.integer :sequence
      t.string :remarks
      t.string :code
      t.boolean :is_active, default: true
      t.integer :lock_version
      t.references :parent_evaluation_component, index: true
      t.references :evaluation_scheme, index: true
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
    add_index :evaluation_components, [:name,:organization_id,:deleted_at],name: "uniqueness_index_for_evaluation_component"
  end
end

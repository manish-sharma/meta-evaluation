class CreateEvaluationSchemeResources < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_scheme_resources do |t|
      t.string :resource_type, null: false
      t.bigint :resource_id, null: false
      t.bigint :academic_year_unit_id, null: false
      t.integer :lock_version
      t.datetime :deleted_at
      t.integer :organization_id, null: false
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false

      t.timestamps
    end

    add_index :evaluation_scheme_resources, [:resource_id,:resource_type,:academic_year_unit_id,:organization_id,:deleted_at],unique: true, name: "uniqueness_index_for_evaluation_scheme_resources"

  end
end

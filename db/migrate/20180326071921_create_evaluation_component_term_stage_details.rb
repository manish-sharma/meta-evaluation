class CreateEvaluationComponentTermStageDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_component_term_stage_details do |t|
      t.references :evaluation_stage, index: { name: "ectsd_es_fk_index" }
      t.decimal :max_marks
      t.references :evaluation_component, index: { name: "ectsd_ec_fk_index" }
      t.bigint :academic_year_id
      t.datetime :deleted_at
      t.integer :organization_id, index:{ name: "ectsd_organization_fk_index" }
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
    add_index :evaluation_component_term_stage_details, [:evaluation_stage_id,:evaluation_component_id,:academic_year_id,:organization_id,:deleted_at],unique: true, name: "uniqueness_index_for_ectsd"
  end
end

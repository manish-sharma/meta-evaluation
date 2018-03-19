class CreateEvaluationTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_terms do |t|
      t.string :name
      t.integer :sequence
      t.boolean :is_active, default: false
      t.references :evaluation_scheme, index: true
      t.bigint :academic_year_id
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

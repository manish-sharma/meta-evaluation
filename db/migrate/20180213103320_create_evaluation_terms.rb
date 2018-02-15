class CreateEvaluationTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_terms do |t|
      t.string :name
      t.datetime :from_date
      t.datetime :to_date
      t.integer :working_days
      t.integer :sequence
      t.boolean :is_active, default: false
      t.datetime :result_submit_date
      t.datetime :result_publish_date
      t.references :evaluation_scheme
      t.bigint :academic_year_structure_id
      t.datetime :deleted_at
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

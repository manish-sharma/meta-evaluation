class CreateEvaluationStages < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_stages do |t|
      t.string :name
      t.integer :sequence
      t.references :evaluation_term
      t.datetime :deleted_at
      t.bigint :academic_year_id
      t.integer :organization_id, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end
  end
end

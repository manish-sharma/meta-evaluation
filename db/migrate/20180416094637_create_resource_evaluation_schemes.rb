class CreateResourceEvaluationSchemes < ActiveRecord::Migration[5.1]
  def change
    create_table :resource_evaluation_schemes do |t|
      # this index name is for default index for reference keys.
      t.references :evaluation_scheme_resource, null: false, index: {name: "index_on_evaluation_scheme_resource"}
      t.references :evaluation_scheme, null: false

      t.integer :lock_version
      t.datetime :deleted_at
      t.integer :organization_id, null: false
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false
      t.timestamps
    end

    add_index :resource_evaluation_schemes, [:evaluation_scheme_resource_id,:organization_id,:deleted_at],unique: true, name: "uniqueness_index_for_resource_evaluation_schemes"

  end
end

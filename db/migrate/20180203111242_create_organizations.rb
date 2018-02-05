class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, index: true, null: false
      t.text :description
      t.string :domain_name, index: true, null: false, unique: true
      t.integer :organization_type, index: true, null: false
      t.string :access_key, index: true
      t.string :created_by, index: true, null: false
      t.string :updated_by, index: true, null: false

      t.timestamps
    end
  end
end

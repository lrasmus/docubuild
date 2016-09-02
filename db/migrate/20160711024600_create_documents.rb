class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :institution
      t.boolean :is_template, index: true, default: false
      t.references :status, index: true, foreign_key: true, null: false
      t.references :visibility, index: true, foreign_key: true, null: false
      t.integer :created_by, index: true, foreign_key: true
      t.integer :updated_by, index: true, foreign_key: true
      t.integer :deleted_by, index: true, foreign_key: true
      t.references :folder, index: true, foreign_key: true
      t.integer :template_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

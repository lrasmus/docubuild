class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :description
      t.text :content
      t.references :status, index: true, foreign_key: true
      t.references :visibility, index: true, foreign_key: true
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :deleted_by_id
      t.references :document, index: true, foreign_key: true
      t.integer :order
      t.integer :template_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.text :content
      t.references :status, index: true, foreign_key: true
      t.references :visibility, index: true, foreign_key: true
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.references :article, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end

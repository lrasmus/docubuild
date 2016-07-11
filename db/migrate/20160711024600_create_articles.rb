class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.references :status, index: true, foreign_key: true
      t.references :visibility, index: true, foreign_key: true
      t.integer :created_by, index: true, foreign_key: true
      t.integer :updated_by, index: true, foreign_key: true
      t.integer :deleted_by, index: true, foreign_key: true
      t.references :folder, index: true, foreign_key: true
      t.integer :template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

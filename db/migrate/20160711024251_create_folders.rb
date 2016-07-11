class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.text :description
      t.references :status, index: true, foreign_key: true
      t.references :visibility, index: true, foreign_key: true
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.integer :parent
      t.integer :owner

      t.timestamps null: false
    end
  end
end

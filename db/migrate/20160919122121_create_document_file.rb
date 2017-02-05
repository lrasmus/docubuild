class CreateDocumentFile < ActiveRecord::Migration
  def change
    create_table :document_files do |t|
      t.references :document, index: true, foreign_key: true
      t.string :name
      t.references :document_file_type, index: true, foreign_key: true
      t.binary :content

      t.timestamps null: false
    end
  end
end

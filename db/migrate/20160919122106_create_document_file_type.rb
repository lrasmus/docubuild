class CreateDocumentFileType < ActiveRecord::Migration
  def change
    create_table :document_file_types do |t|
      t.string :name
      t.string :category
      t.string :mime_type
      t.string :extension

      t.timestamps null: false
    end
  end
end

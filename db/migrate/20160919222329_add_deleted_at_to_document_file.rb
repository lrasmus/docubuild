class AddDeletedAtToDocumentFile < ActiveRecord::Migration
  def change
    add_column :document_files, :deleted_at, :datetime
    add_index :document_files, :deleted_at
  end
end

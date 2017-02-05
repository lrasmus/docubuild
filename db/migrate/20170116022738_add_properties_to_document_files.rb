class AddPropertiesToDocumentFiles < ActiveRecord::Migration
  def change
    add_column :document_files, :properties, :json
  end
end

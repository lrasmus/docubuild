class AddVersionsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :template_version, :integer
    add_column :documents, :clone_source_version, :integer
  end
end

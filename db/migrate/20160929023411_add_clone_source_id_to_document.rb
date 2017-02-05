class AddCloneSourceIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :clone_source_id, :integer
    add_index :documents, :clone_source_id
  end
end

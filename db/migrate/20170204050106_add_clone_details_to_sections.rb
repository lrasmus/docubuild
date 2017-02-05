class AddCloneDetailsToSections < ActiveRecord::Migration
  def change
    add_column :sections, :clone_source_id, :integer
    add_column :sections, :clone_source_version, :integer
  end
end

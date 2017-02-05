class AddVersionToSections < ActiveRecord::Migration
  def change
    add_column :sections, :template_version, :integer
  end
end

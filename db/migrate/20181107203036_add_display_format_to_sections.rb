class AddDisplayFormatToSections < ActiveRecord::Migration[5.0]
  def change
    add_column :sections, :display_format, :json
  end
end

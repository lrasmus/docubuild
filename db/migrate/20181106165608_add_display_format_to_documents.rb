class AddDisplayFormatToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :display_format, :json
  end
end

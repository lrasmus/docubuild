class AddStyleToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :style, :json
  end
end

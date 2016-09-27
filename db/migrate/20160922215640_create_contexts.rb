class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.integer :item_id, index: true
      t.string :item_type, index: true
      t.string :category
      t.string :code
      t.string :code_system_oid
      t.string :code_system_name
      t.string :term

      t.timestamps null: false
    end
  end
end

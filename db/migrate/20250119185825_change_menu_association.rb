class ChangeMenuAssociation < ActiveRecord::Migration[7.2]
  def change
    rename_column :menu_items, :page_id, :record_id
    add_column :menu_items, :record_type, :string
    add_index :menu_items, [:record_id, :record_type]
    add_index :menu_items, :record_type
  end
end

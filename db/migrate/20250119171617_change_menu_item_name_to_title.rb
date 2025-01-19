class ChangeMenuItemNameToTitle < ActiveRecord::Migration[7.2]
  def change
    rename_column :menu_items, :name, :title
  end
end

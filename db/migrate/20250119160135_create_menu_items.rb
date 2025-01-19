class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.belongs_to :page
      t.string :url
      t.integer :row_order
      t.belongs_to :site, null: false

      t.timestamps
    end
  end
end

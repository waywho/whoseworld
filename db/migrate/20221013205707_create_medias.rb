class CreateMedias < ActiveRecord::Migration[7.0]
  def change
    create_table :medias do |t|
      t.string :title
      t.text :source
      t.belongs_to :page, null: false, foreign_key: true
      t.belongs_to :site, null: true, foreign_key: true
      t.string :media_type
      t.integer :row_order, null: true

      t.timestamps
    end
  end
end

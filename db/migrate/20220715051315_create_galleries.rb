class CreateGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :galleries do |t|
      t.string :description
      t.references :page, foreign_key: true

      t.timestamps
    end
  end
end

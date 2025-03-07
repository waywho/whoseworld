class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.references :imageable, polymorphic: true
      t.string :kind
      t.string :cid

      t.timestamps
    end

    add_index :images, [:imageable_type, :imageable_id, :kind]
  end
end

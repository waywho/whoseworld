class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.jsonb :address, default: {}
      t.string :display_name
      t.string :lat
      t.string :lon
      t.text :boundingbox, array: true, default: []
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end

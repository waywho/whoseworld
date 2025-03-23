class CreateBURMSongs < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_songs do |t|
      t.belongs_to :burm_musical, null: false, foreign_key: true
      t.integer :order
      t.string :title

      t.timestamps
    end
  end
end

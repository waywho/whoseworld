class CreateBURMRehearsalOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_rehearsal_orders do |t|
      t.belongs_to :burm_musical, null: false, foreign_key: true
      t.belongs_to :burm_song, null: false, foreign_key: true
      t.integer :block
      t.integer :order
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end

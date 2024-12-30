class CreateBurmShows < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_shows do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.string :location
      t.decimal :fee, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end

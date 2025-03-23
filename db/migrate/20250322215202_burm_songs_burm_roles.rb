class BURMSongsBURMRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_songs_burm_roles do |t|
      t.belongs_to :burm_song, null: false, foreign_key: true
      t.belongs_to :burm_role, null: false, foreign_key: true
    end
  end
end

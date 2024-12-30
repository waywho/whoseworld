class AddMusicalAssociation < ActiveRecord::Migration[7.2]
  def change
    rename_table :burm_shows, :burm_musicals
    rename_column :burm_roles, :burm_show_id, :burm_musical_id
    rename_column :burm_signups, :burm_show_id, :burm_musical_id
  end
end

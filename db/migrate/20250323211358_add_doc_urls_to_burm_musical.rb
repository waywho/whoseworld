class AddDocUrlsToBURMMusical < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :schedule_url, :string
    add_column :burm_musicals, :songlist_url, :string
  end
end

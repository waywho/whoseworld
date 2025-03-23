class AddPageNumberToBURMSongs < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_songs, :page_number, :integer
  end
end

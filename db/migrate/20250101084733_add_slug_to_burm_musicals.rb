class AddSlugToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :slug, :string
    add_index :burm_musicals, :slug, unique: true
  end
end

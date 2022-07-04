class AddSubtitleToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :subtitle, :string
  end
end

class AddPublicToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :public, :boolean, default: false
  end
end

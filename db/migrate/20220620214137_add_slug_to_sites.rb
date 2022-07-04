class AddSlugToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :slug, :string, index: true
  end
end

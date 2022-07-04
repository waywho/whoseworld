class AddOrientationToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :orientation, :string
  end
end

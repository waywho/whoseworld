class AddFeatureToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :feature, :boolean, default: false, null: false
  end
end

class AddTitleToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :title, :string
  end
end

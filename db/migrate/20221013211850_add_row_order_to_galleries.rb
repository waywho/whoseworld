class AddRowOrderToGalleries < ActiveRecord::Migration[7.0]
  def change
    add_column :galleries, :row_order, :integer, null: true
  end
end

class AddRowOrderToImages < ActiveRecord::Migration[7.2]
  def change
    add_column :images, :row_order, :integer
  end
end

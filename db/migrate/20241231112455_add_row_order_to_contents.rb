class AddRowOrderToContents < ActiveRecord::Migration[7.2]
  def change
    add_column :contents, :row_order, :integer, null: true
  end
end

class AddRowOrderToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :row_order, :integer, null: true
  end
end

class AddSummaryToContent < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :summary, :string
  end
end

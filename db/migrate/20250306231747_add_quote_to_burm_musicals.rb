class AddQuoteToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :quote, :string
  end
end

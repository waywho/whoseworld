class AddLocationNameToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :location_name, :string
  end
end

class AddTimezoneCountryToBURMPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_people, :timezone, :string
    add_column :burm_people, :country_code, :string
    add_column :burm_people, :region, :string
  end
end

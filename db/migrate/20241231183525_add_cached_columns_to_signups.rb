class AddCachedColumnsToSignups < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_signups, :musical_title, :string
    add_column :burm_signups, :person_name, :string
    add_column :burm_signups, :role_name, :string
  end
end

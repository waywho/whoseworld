class AddAdditionalFieldsToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :roles_assigned_at, :datetime
    add_column :burm_musicals, :excerpt_url, :string
  end
end

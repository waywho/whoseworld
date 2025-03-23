class AddBroadcastDatesToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :published_at, :datetime
    add_column :burm_musicals, :signup_broadcasted_at, :datetime
    add_column :burm_musicals, :roles_broadcasted_at, :datetime
    add_column :burm_musicals, :join_instructions_broadcasted_at, :datetime
  end
end

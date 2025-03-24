class RenameBroadcastColumnNameToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    rename_column :burm_musicals, :signup_broadcasted_at, :signup_sent_at
    rename_column :burm_musicals, :roles_broadcasted_at, :roles_sent_at
    rename_column :burm_musicals, :joining_instructions_broadcasted_at, :joining_instructions_sent_at
  end
end

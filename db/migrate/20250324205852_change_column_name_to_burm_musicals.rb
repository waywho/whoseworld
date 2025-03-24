class ChangeColumnNameToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    rename_column :burm_musicals, :join_instructions_broadcasted_at, :joining_instructions_broadcasted_at
  end
end

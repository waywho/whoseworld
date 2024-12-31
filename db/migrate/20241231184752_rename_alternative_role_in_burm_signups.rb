class RenameAlternativeRoleInBURMSignups < ActiveRecord::Migration[7.2]
  def change
    rename_column :burm_signups, :alternative_role, :alternative_role_id
  end
end

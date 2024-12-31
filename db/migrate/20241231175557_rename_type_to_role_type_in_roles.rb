class RenameTypeToRoleTypeInRoles < ActiveRecord::Migration[7.2]
  def change
    rename_column :burm_roles, :type, :role_type
  end
end

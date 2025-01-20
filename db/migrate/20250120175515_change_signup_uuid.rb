class ChangeSignupUuid < ActiveRecord::Migration[7.2]
  def up
    add_column :burm_signups, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :burm_signups, :id, :integer_id
    rename_column :burm_signups, :uuid, :id
    remove_column :burm_signups, :integer_id
    execute "ALTER TABLE burm_signups ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

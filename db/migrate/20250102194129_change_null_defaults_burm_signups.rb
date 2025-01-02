class ChangeNullDefaultsBURMSignups < ActiveRecord::Migration[7.2]
  def change
    change_column_null :burm_signups, :burm_person_id, true
    change_column_null :burm_signups, :burm_role_id, true
    change_column_null :burm_signups, :burm_musical_id, true
  end
end

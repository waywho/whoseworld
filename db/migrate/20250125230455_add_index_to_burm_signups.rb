class AddIndexToBURMSignups < ActiveRecord::Migration[7.2]
  def change
    add_index :burm_signups, [:burm_person_id, :burm_musical_id], unique: true
    add_index :burm_signups, [:burm_person_id, :burm_role_id, :burm_musical_id]
  end
end

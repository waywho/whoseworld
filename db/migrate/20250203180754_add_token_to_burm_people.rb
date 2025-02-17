class AddTokenToBURMPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_people, :confirmation_token_expires_at, :datetime

    add_index :burm_people, :confirmation_token, unique: true
  end
end

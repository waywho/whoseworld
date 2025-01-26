class AddSignupDatetimeToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :signup_start_at, :datetime
  end
end

class AddSignupCancellation < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_signups, :cancelled, :boolean
    add_column :burm_signups, :cancelled_at, :datetime
    add_column :burm_signups, :cancellation_reason, :text
  end
end

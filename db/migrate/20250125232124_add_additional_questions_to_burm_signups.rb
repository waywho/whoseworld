class AddAdditionalQuestionsToBURMSignups < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_signups, :assigned_burm_role_id, :bigint
    add_column :burm_signups, :role_sharing, :boolean
    add_column :burm_signups, :family_friends_watching, :boolean
    add_column :burm_signups, :commit_to_pay, :boolean, default: true, null: false
    add_column :burm_signups, :comments, :text
  end
end

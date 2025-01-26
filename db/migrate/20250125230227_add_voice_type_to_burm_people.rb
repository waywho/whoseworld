class AddVoiceTypeToBURMPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_people, :voice_type, :integer, default: 0, null: false
    add_column :burm_people, :agree_to_emails, :boolean, default: true, null: false
    add_index :burm_people, :voice_type
    add_index :burm_people, :email
  end
end

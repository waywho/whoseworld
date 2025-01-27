class AddAdditionalColumnsToBURMPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_people, :confirmed_at, :datetime
    add_column :burm_people, :confirmation_token, :string
    add_column :burm_people, :agree_to_terms_at, :datetime
    add_column :burm_people, :agree_to_terms, :boolean
    add_column :burm_people, :agree_to_emails_at, :datetime

    BURM::Person.all.each do |person|
      person.update(agree_to_emails_at: Time.current) if person.agree_to_emails
    end
  end
end

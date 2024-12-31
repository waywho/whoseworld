class CreateBURMPeople < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps
    end
  end
end

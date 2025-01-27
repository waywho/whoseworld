class ChangeUuidToBURMPeople < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_people, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :burm_people do |t|
      t.rename :id, :integer_id
      t.rename :uuid, :id
    end
    add_index :burm_people, :id, unique: true
    remove_foreign_key :burm_signups, column: :burm_person_id
    add_column :burm_signups, :burm_person_uuid, :uuid

    BURM::Signup.all.each do |signup|
      signup.update_column(:burm_person_uuid, signup.person.id)
    end

    remove_column :burm_people, :integer_id
    remove_column :burm_signups, :burm_person_id
    rename_column :burm_signups, :burm_person_uuid, :burm_person_id
    add_foreign_key :burm_signups, :burm_people, column: :burm_person_id

    execute "ALTER TABLE burm_people ADD PRIMARY KEY (id);"
  end

  def down
    remove_foreign_key :burm_signups, column: :burm_person_id
    remove_column :burm_signups, :burm_person_id
    add_column :burm_people, :integer_id, :bigint
    add_column :burm_signups, :burm_person_id, :bigint
    BURM::Signup.all.each do |signup|
      signup.update_column(:burm_person_id, signup.person.id)
    end
    remove_column :burm_people, :id
    change_table :burm_people do |t|
      t.rename :integer_id, :id
    end
    add_foreign_key :burm_signups, :burm_people, column: :burm_person_id
    remove_column :burm_people, :uuid
  end
end

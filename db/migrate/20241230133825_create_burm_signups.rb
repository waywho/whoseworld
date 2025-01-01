class CreateBURMSignups < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_signups do |t|
      t.belongs_to :burm_person, null: false, foreign_key: true
      t.belongs_to :burm_role, null: false, foreign_key: true
      t.belongs_to :burm_show, null: false, foreign_key: true
      t.bigint :alternative_role

      t.timestamps
    end
  end
end

class CreateBURMRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :burm_roles do |t|
      t.string :name
      t.belongs_to :burm_show, null: false, foreign_key: true
      t.integer :voice_type
      t.integer :type

      t.timestamps
    end
  end
end

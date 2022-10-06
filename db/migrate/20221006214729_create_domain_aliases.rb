class CreateDomainAliases < ActiveRecord::Migration[7.0]
  def change
    create_table :domain_aliases do |t|
      t.string :domain
      t.string :subdomain
      t.belongs_to :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end

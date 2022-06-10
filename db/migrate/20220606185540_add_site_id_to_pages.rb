class AddSiteIdToPages < ActiveRecord::Migration[7.0]
  def change
    add_reference :pages, :site, null: false, foreign_key: true
  end
end

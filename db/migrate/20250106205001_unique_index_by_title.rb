class UniqueIndexByTitle < ActiveRecord::Migration[7.2]
  def change
    add_index :pages, [:site_id, :title], unique: true
  end
end

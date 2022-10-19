class RemoveIndexUniqueOnPages < ActiveRecord::Migration[7.0]
  def change
    remove_index :pages, :slug, unique: true
  end
end

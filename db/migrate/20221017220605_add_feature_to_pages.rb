class AddFeatureToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :feature, :boolean, default: false
  end
end

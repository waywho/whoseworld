class AddTemplateToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :template, :string
  end
end

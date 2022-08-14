class AddTemplateStyleToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :template_style, :string
  end
end

ActiveAdmin.register Page do
  permit_params :title, :menu, :slug, :site_id, :row_order, :template, :feature
  config.sort_order = "row_order_asd"
  config.filters = false
  
  scope :all, default: true

  Site.all.each do |site|
    scope(site.slug) { |scope| scope.where(site:) }
  end

  index do
    column :row_order
    column :title
    column :slug
    column :template
    column :feature
  end
end

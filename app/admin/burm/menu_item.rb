# frozen_string_literal: true

ActiveAdmin.register MenuItem do
  permit_params :name, :page_id, :url, :row_order, :site_id
  config.sort_order = "row_order_asc"

  scope :all, default: true

  Site.all.each do |site|
    scope(site.slug.to_sym)
  end

  index do
    column :title
    column :site
    column :record
    column :url
    column :row_order
    actions
  end

  form do |f|
    f.inputs do
      f.input :site
      f.input :title
      f.input :record, collection: Page.all
      f.input :url
      f.input :row_order
    end
    f.actions
  end
end

# frozen_string_literal: true

ActiveAdmin.register Media do
  permit_params :title, :source, :page_id, :site_id, :media_type, :row_order
  config.sort_order = "row_order_asc"

  # Site.all.each do |site|
  #   scope(site.slug.to_sym)
  # end

  index do
    column :page
    column :title
    column :media_type
    column :row_order
  end

  form do |f|
    f.input :title
    f.input :source
    f.input :media_type, as: :select, collection: Media.types
    f.input :row_order, label: "Order"
    f.input :page
    f.input :site
    f.actions
  end
end

# frozen_string_literal: true

ActiveAdmin.register Page do
  permit_params :title, :menu, :slug, :site_id, :row_order, :template, :kind,
                contents_attributes: %i[id heading summary body _destroy]
  config.sort_order = "row_order_asc"
  config.filters = false

  scope :all, default: true

  Site.all.each do |site|
    scope(site.slug.to_sym)
  end

  index do
    column :row_order
    column :title
    column :slug, input_html: { disabled: true }
    column :template
    column :feature
    column :menu
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :site
      f.input :template
      f.input :row_order
      f.input :kind, collection: Page::KIND_LABELS.invert.to_a
    end
    
    f.inputs "Contents" do
      f.has_many :contents, heading: false,  sortable: :row_order, sortable_start: 1, allow_destroy: true do |c|
        c.input :id, as: :hidden
        c.input :heading
        c.input :summary
        c.input :body
      end
    end
    f.actions
  end
end

# frozen_string_literal: true

ActiveAdmin.register Page do
  permit_params :title, :menu, :slug, :site_id, :row_order, :template, :feature,
                contents_attributes: %i[heading summary body _destroy]
  config.sort_order = "row_order_asc"
  config.filters = false

  scope :all, default: true

  Site.all.each do |site|
    scope(site.slug) { |scope| scope.where(site_id: site.id) }
  end

  index do
    column :row_order
    column :title
    column :slug
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
      f.input :feature
    end
    
    f.inputs "Contents" do
      f.has_many :contents, heading: false,  sortable: :row_order, sortable_start: 1, allow_destroy: true do |c|
        c.input :heading
        c.input :summary
        c.input :body
      end
    end
    f.actions
  end

  # https://stackoverflow.com/a/58774667/6076225
  controller do

    before_action :reload_scopes, only: :index

    def reload_scopes
      resource_config = active_admin_config

      resource_config.instance_variable_set(:@scopes, [
        resource_config.scopes.first ### Default scope
      ])

      Site.all.each do |site|
        next if resource_config.scopes.first.name ==  site.name

        resource_config.scopes << ActiveAdmin::Scope.new(site.name){|scope| scope.where(site_id: site.id) }
      end
    end
  end
end

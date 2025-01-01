# frozen_string_literal: true

ActiveAdmin.register Site do
  permit_params :name, :subtitle, :domain, :subdomain, :slug, :orientation, :template_style, :public,
                :logo, domain_aliases_attributes: [:domain, :subdomain]

  index do
    id_column
    column :name
    column :domain
    column :subdomain
    column :created_at
    column :public
    actions
  end

  filter :name
  filter :domain

  form do |f|
    f.inputs do
      f.input :name
      f.input :subtitle
      f.input :domain
      f.input :subdomain
      f.input :slug
      f.input :orientation, collection: Site.orientations
      f.input :template_style, collection: Site.site_styles
      f.input :public
      f.file_field :logo
    end

    f.inputs "DomainAliases" do
      f.has_many :domain_aliases, heading: false, allow_destroy: true do |a|
        a.input :domain
        a.input :subdomain
      end
    end

    f.actions
  end
end

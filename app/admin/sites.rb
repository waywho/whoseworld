# frozen_string_literal: true

ActiveAdmin.register Site do
  permit_params :id, :name, :subtitle, :domain, :subdomain, :slug, :nav_position, :layout_style, :public,
                :logo, domain_aliases_attributes: [:id, :domain, :subdomain]

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
      f.input :id, as: :hidden
      f.input :name
      f.input :subtitle
      f.input :domain
      f.input :subdomain
      f.input :slug
      f.input :nav_position
      f.input :layout_style
      f.input :public
      f.file_field :logo
    end

    f.inputs "DomainAliases" do
      f.has_many :domain_aliases, heading: false, allow_destroy: true do |a|
        a.input :id, as: :hidden
        a.input :domain
        a.input :subdomain
      end
    end

    f.actions
  end
end

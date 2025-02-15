# frozen_string_literal: true

ActiveAdmin.register Site do
  permit_params :id, :name, :subtitle, :domain, :subdomain, :slug, :nav_position, :layout_style,
                :public, :logo, :logo_for_dark, :logo_with_tag, :logo_with_tag_for_dark, 
                domain_aliases_attributes: [:id, :domain, :subdomain]

  form partial: "form"

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
end

ActiveAdmin.register Site do
  permit_params :name, :subtitle, :domain, :subdomain, :slug, :orientation, :template_style, :public

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
      f.input :orientation
      f.input :template_style
      f.input :public
    end
    f.actions
  end
end

# frozen_string_literal: true

ActiveAdmin.register Gallery do
  permit_params :title, :description, :page_id, :feature, :row_order, images: []
  form partial: "form"

  index do
    column :page
    column :row_order
    column :title
    column :description
    column :feature
    actions
  end
end

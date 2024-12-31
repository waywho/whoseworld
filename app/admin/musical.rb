# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  permit_params :title, :start_at, :end_at, :location, :fee, :roles

  index do
    selectable_column
    id_column
    column :title
    column :start_at
    column :end_at
    column :location
    column :fee
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :start_at
      f.input :end_at
      f.input :location
      f.input :fee
    end

    if f.object.new_record?
      f.inputs :bulk_roles, as: :text, label: "Roles", hint: "Enter one role per line Name (Voice Type) Type"
    else
      f.inputs "Roles" do
        f.has_many :roles, heading: false, allow_destroy: true do |r|
          r.input :name
          r.input :voice_type
          r.input :role_type
        end
      end
    end
    f.actions
  end
end

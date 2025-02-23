# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  permit_params :title, :start_at, :end_at, :location, :fee, :bulk_roles, :signup_start_at, :image,
                roles_attributes: [:id, :name, :voice_type, :role_type, :_destroy]

  index do
    selectable_column
    id_column
    column :title
    column :slug, :input_html => { :disabled => true }
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
      f.input :signup_start_at
      f.input :image, as: :file
      li f.object.image.filename if f.object.image.attached?
    end


    if f.object.new_record? || f.object.roles.blank?
      f.inputs :bulk_roles, as: :text, label: "Roles", hint: "Enter one role per line Name (Voice Type) Type"
    else
      f.inputs "Roles" do
        f.has_many :roles, heading: false, allow_destroy: true do |r|
          r.input :id, as: :hidden
          r.input :name
          r.input :voice_type
          r.input :role_type
        end
      end
    end
    f.actions
  end
end

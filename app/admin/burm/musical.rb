# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  permit_params :title, :start_at, :quote, :end_at, :location, :fee, :bulk_roles, :signup_start_at, :image,
                roles_attributes: [:id, :name, :voice_type, :role_type, :_destroy],
                address_attributes: [:id, :address, :lat, :lon, :boundingbox, :_destroy],
                image: [:id, :cid, :kind, :image_file]

  member_action :annouce_next, method: :put do
    resource.annouce_next
    redirect_to resource_path(resource), notice: "Annouced!"
  end

  member_action :annouce_test, method: :put do
    resource.annouce_next(test: true)
    redirect_to resource_path(resource), notice: "Test Annouced!"
  end

  action_item :annouce_next, :only => [:show, :edit] do
    link_to "Annouce Next", annouce_next_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  action_item :annouce_test, :only => [:show, :edit] do
    link_to "Annouce Test", annouce_test_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

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
      f.input :quote
      f.input :end_at
      f.input :location
      f.input :fee
      f.input :signup_start_at
    end

    f.inputs "Cover Image" do
      f.has_many :image, heading: false, allow_destroy: true do |i|
        i.input :id, as: :hidden
        i.input :cid
        i.input :kind
        i.input :image_file, as: :file
        li i.object.image.filename if i.object&.image&.attached?
      end
    end

    f.inputs "Address" do
      f.has_many :address, heading: false, allow_destroy: true, new_record: false do |a|
        a.input :id, as: :hidden
        a.input :address
        a.input :lat
        a.input :lon
        a.input :boundingbox
      end
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

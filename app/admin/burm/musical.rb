# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  permit_params :title, :start_at, :quote, :end_at, :location, :fee, :bulk_roles, :signup_start_at, :image,
                roles_attributes: [:id, :name, :voice_type, :role_type, :_destroy],
                address_attributes: [:id, :address, :lat, :lon, :boundingbox, :_destroy],
                image: [:id, :cid, :kind, :image_file]

  member_action :broadcast, method: :put do
    resource.broadcast if Rails.env.production?
    redirect_to resource_path(resource), notice: "Broadcasted!"
  end

  action_item :broadcast, :only => [:show, :edit] do
    link_to "Broadcast", broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  member_action :broadcast_test, method: :put do
    resource.broadcast(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted!"
  end

  action_item :broadcast_test, :only => [:show, :edit] do
    link_to "Test Broadcast", broadcast_test_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  member_action :signup_broadcast, method: :put do
    resource.broadcast_signup if Rails.env.production?
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
  end

  action_item :signup_broadcast, :only => [:show, :edit] do
    link_to "Open Signup", signup_broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  member_action :test_signup_broadcast, method: :put do
    resource.broadcast_signup(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
  end

  action_item :test_signup_broadcast, :only => [:show, :edit] do
    link_to "Test Open Signup", test_signup_broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
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

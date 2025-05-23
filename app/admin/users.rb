# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  scope :all, default: true
  scope("Admin") { |scope| scope.where(admin: true) }


  index do
    selectable_column
    id_column
    column :admin
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end

# frozen_string_literal: true

ActiveAdmin.register BURM::Person do
  permit_params :first_name, :last_name, :email

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.title) { |scope| scope.includes(:burm_musicals).where(burm_musicals: musical) }
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
    end
    f.actions
  end
end

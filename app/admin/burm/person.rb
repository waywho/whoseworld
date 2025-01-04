# frozen_string_literal: true

ActiveAdmin.register BURM::Person do
  permit_params :first_name, :last_name, :email, signups_attributes: [:id, :burm_person_id, :burm_musical_id,
                :burm_role_id, :alternative_role_id, :_destroy]

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.symbolized_slug) { |scope| scope.includes(:musicals).where(musicals: { id: musical.id }) }
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

    f.inputs "Signups" do
      f.has_many :signups, heading: false, allow_destroy: true do |s|
        s.input :id, as: :hidden
        s.input :musical, collection: BURM::Musical.all
        s.input :role, collection: BURM::Role.all
        s.input :alternative_role
      end
    end

    f.actions
  end
end

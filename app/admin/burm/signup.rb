# frozen_string_literal: true

ActiveAdmin.register BURM::Signup do
  permit_params :burm_person_id, :burm_role_id, :burm_musical_id, :alternative_role_id,
                person_attributes: [:id, :first_name, :last_name, :email]

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.symbolized_slug)
  end

  index do
    selectable_column
    id_column
    column :person
    column :musical
    column :role
    column :alternative_role
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :musical
      f.input :role
      f.input :alternative_role
      f.input :musical_title, disabled: true
      f.input :person_name, disabled: true
      f.input :role_name, disabled: true
    end

    f.inputs "Person" do
      f.belongs_to :person, label: false, required: true do
        f.input :first_name
        f.input :last_name
        f.input :email
      end
    end
    f.actions
  end

  csv do
    column(:last_name) { |signup| signup.person.last_name }
    column(:first_name) { |signup| signup.person.last_name }
    column(:role) { |signup| signup.role.name }
    column(:musical) { |signup| signup.musical.title }
    column(:paid)
  end
end

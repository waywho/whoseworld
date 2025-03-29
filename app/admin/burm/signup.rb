# frozen_string_literal: true

ActiveAdmin.register BURM::Signup do
  permit_params :burm_person_id, :burm_role_id, :burm_musical_id, :alternative_role_id, :cancelled, :cancelled_at, :cancellation_reason, :role_sharing, :assigned_burm_role_id,
                :assigned_burm_role_id,
                person_attributes: [:id, :first_name, :last_name, :email]

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.symbolized_slug)
  end

  index do
    selectable_column
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
      f.input :id, as: :string, disabled: true
      f.input :musical
      f.input :role
      f.input :alternative_role
      f.input :assigned_burm_role_id
      f.input :musical_title, input_html: { disabled: true }
      f.input :person_name, input_html: { disabled: true }
      f.input :role_name, input_html: {  disabled: true }
      f.input :cancelled
      f.input :cancelled_at
      f.input :cancellation_reason
    end

    f.inputs "Person" do
      f.has_many :person, heading: false, required: true do |p|
        p.input :id, as: :hidden
        p.input :first_name
        p.input :last_name
        p.input :email
      end
    end
    f.actions
  end

  csv do
    column(:last_name) { |signup| signup.person.last_name }
    column(:first_name) { |signup| signup.person.last_name }
    column(:role) { |signup| signup.role&.name }
    column(:musical) { |signup| signup.musical&.title }
    column(:assigned_role) { |signup| signup.assigned_burm_role&.name }
    column(:alternative_role) { |signup| signup.alternative_role&.name }
    column(:cancelled) { |signup| signup.cancelled_at }
  end
end

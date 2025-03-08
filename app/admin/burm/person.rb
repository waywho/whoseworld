# frozen_string_literal: true

ActiveAdmin.register BURM::Person do
  permit_params :first_name, :last_name, :email, :voice_type, :confirmed_at,
                :agree_to_terms, :agree_to_terms_at, :agree_to_emails,
                :agree_to_emails_at,
                signups_attributes: [:id, :burm_person_id, :burm_musical_id,
                :burm_role_id, :alternative_role_id, :_destroy]

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.symbolized_slug) { |scope| scope.includes(:musicals).where(musicals: { id: musical.id }) }
  end

  action_item :only => :index do
    link_to 'Upload CSV', upload_csv_admin_burm_people_path, class: "action-item-button"
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    count = CsvDb.convert_save(resource_class.name, params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully! #{count} records added."
  end

  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :voice_type
    column :confirmed_at
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :id, as: :string
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :voice_type, as: :select, collection: BURM::Person.voice_types.keys
      f.input :confirmed_at
      f.input :agree_to_terms
      f.input :agree_to_terms_at
      f.input :agree_to_emails
      f.input :agree_to_emails_at
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

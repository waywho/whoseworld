# frozen_string_literal: true

ActiveAdmin.register BURM::Role do
  permit_params :name, :burm_musical_id, :voice_type, :role_type

  scope :all, default: true

  BURM::Musical.all.each do |musical|
    scope(musical.symbolized_slug)
  end

  index do
    selectable_column
    column :name
    column :musical
    column :voice_type
    column :role_type
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :musical, collection: BURM::Musical.all
      f.input :voice_type, collection: BURM::Role.voice_types
      f.input :role_type, collection: BURM::Role.role_types
    end
    f.actions
  end
end

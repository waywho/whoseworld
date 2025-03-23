ActiveAdmin.register BURM::Song do
  # Specify parameters which should be permitted for assignment
  permit_params :burm_musical_id, :order, :title, role_ids: []

  # or consider:
  #
  # permit_params do
  #   permitted = [:burm_musical_id, :order, :title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :burm_musical
  filter :order
  filter :title
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :burm_musical
    column :order
    column :title
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :burm_musical
      row :order
      row :title
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :burm_musical_id, as: :select, collection: BURM::Musical.all.map { |m| [m.title, m.id] }
      f.input :order
      f.input :title
    end
    f.inputs :roles, as: :check_boxes, collection: BURM::Role.includes(:musical).all.map { |r| ["#{r.name}-#{r.musical.title}", r.id] }
    f.actions
  end
end

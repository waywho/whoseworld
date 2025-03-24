# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  permit_params :title, :start_at, :quote, :end_at, :location_name, :location, :fee,
                :bulk_roles, :bulk_songs, :signup_start_at, :image, :roles_assigned_at,
                :published_at, :roles_broadcasted_at, :signup_broadcasted_at,
                :excerpt_url, :schedule_url, :songlist_url,
                :checkin_instructions, :additional_joining_info,
                roles_attributes: [:id, :name, :voice_type, :role_type, :_destroy],
                address_attributes: [:id, :address, :lat, :lon, :boundingbox, :direction_notes, :_destroy],
                image: [:id, :cid, :kind, :image_file],
                songs_attributes: [:id, :title, :page_number, :_destroy, role_ids: []],
                rehearsal_orders_attributes: [:id, :block, :order, :burm_song_id, :_destroy]

  # Broadcast
  member_action :broadcast, method: :put do
    resource.broadcast if Rails.env.production?
    redirect_to resource_path(resource), notice: "Broadcasted!"
  end

  action_item :broadcast, :only => [:show, :edit] do
    link_to "Broadcast", broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put, disabled: resource.published_at?
  end

  # Test Broadcast
  member_action :broadcast_test, method: :put do
    resource.broadcast(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted!"
  end

  action_item :broadcast_test, :only => [:show, :edit] do
    link_to "Test Broadcast", broadcast_test_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  # Signup Broadcast
  member_action :signup_broadcast, method: :put do
    resource.broadcast_signup if Rails.env.production?
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
  end

  action_item :signup_broadcast, :only => [:show, :edit] do
    link_to "Open Signup", signup_broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  # Test Signup Broadcast
  member_action :test_signup_broadcast, method: :put do
    resource.broadcast_signup(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
  end

  action_item :test_signup_broadcast, :only => [:show, :edit] do
    link_to "Test Open Signup", test_signup_broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  # Broadcast Joining Instructions
  member_action :joining_instructions_broadcast, method: :put do
    if resource.schedule_url.present?
      resource.broadcast_joining_instructions
      redirect_to resource_path(resource), notice: "Broadcasted Joining Instructions!"
    else
      redirect_to resource_path(resource), alert: "Schedule URL is missing!"
    end
  end

  action_item :joining_instructions_broadcast, :only => [:show, :edit] do
    link_to "Broadcast Joining Instructions", joining_instructions_broadcast_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  # Test Broadcast Joining Instructions
  member_action :preview_joining_instructions, method: :get do
    @mail = Mailers::MusicalsMailerParser.mailer_compose(resource, current_user, :joining_instructions).html_part.decoded.html_safe
    # resource.broadcast_joining_instructions(test: true)
    # redirect_to resource_path(resource), notice: "Broadcasted Joining Instructions!"
    render :mail_preview
  end

  action_item :preview_joining_instructions, :only => [:show, :edit] do
    link_to "Preview Joining Instructions", preview_joining_instructions_admin_burm_musical_path(resource), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  action_item :assign_roles, :only => [:show, :edit]  do
    link_to "Assign Roles", assign_roles_admin_burm_musical_path(resource), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  member_action :assign_roles, method: [:get, :put] do
    @roles = resource.roles
    @signups = resource.signups.includes(:person).order(:created_at)
    @assigned_role_ids = @signups.pluck(:assigned_burm_role_id).compact.uniq

    if request.put?
      signup = BURM::Signup.find(params[:burm_signup][:id])
      signup.update!(assigned_burm_role_id: params[:burm_signup][:assigned_burm_role_id])
      redirect_to assign_roles_admin_burm_musical_path(resource)
    else
      render :assign_roles
    end
  end

  action_item :songs, :only => [:show, :edit]  do
    link_to "Songs", songs_admin_burm_musical_path(resource), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  member_action :songs, method: [:get, :put] do
    @roles = resource.roles
    @songs = resource.songs.order(:order)

    if request.put?
      params.permit!
      resource.update(params[:burm_musical])
      redirect_to songs_admin_burm_musical_path(resource)
    else
      render :songs
    end
  end

  action_item :rehearsal, :only => [:show, :edit]  do
    link_to "Rehearsal", rehearsal_admin_burm_musical_path(resource), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  member_action :rehearsal, method: [:get, :put] do
    @songs = resource.songs.order(:order)

    if request.put?
      params.permit!
      resource.update(params[:burm_musical])
      redirect_to rehearsal_admin_burm_musical_path(resource)
    else
      rehearsal_block_no = (@songs.size - resource.rehearsal_orders.size)
      (0..rehearsal_block_no).to_a.in_groups(4).each_with_index { |group, index| group.compact.map.with_index { |n, m_index| resource.rehearsal_orders.build(block: index + 1, order: m_index + 1) } }

      resource.rehearsal_orders.group_by(&:block)
      render :rehearsal
    end
  end

  action_item :broadcast_assignments, :only => [:show, :edit]  do
    link_to "Broadcast Assignments", broadcast_assignments_admin_burm_musical_path(resource), class: "action-item-button", method: :put, disabled: resource.roles_broadcasted_at?
  end

  member_action :broadcast_assignments, method: :put do
    if resource.excerpt_url.present?
      resource.broadcast_roles if Rails.env.production?
    else
      redirect_to resource_path(resource), alert: "Excerpt URL is missing!"
    end
  end

  action_item :broadcast_assignments_test, :only => [:show, :edit]  do
    link_to "Broadcast Assignments Test", broadcast_assignments_admin_burm_musical_path(resource), class: "action-item-button", method: :put
  end

  member_action :broadcast_assignments_test, method: :put do
    resource.broadcast_roles(test: true)
  end

  action_item :export_songs, :only => [:songs]  do
    link_to "Export", export_songs_admin_burm_musical_path(resource, format: "csv"), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  member_action :export_songs, method: :get do
    csv = CsvDb.export(resource, :songs, json_options: { only: %i[order title page_number], methods: [:role_list] }, assoc_preload: [:roles], order: [:order])

    respond_to do |format|
      format.csv { send_data csv, filename: "#{resource.title.parameterize}-songs.csv" }
    end
  end

  action_item :export_rehearsal, :only => [:rehearsal]  do
    link_to "Export", export_rehearsal_admin_burm_musical_path(resource, format: "csv"), class: "action-item-button", method: :get, data: { "turbo-stream": "" }
  end

  member_action :export_rehearsal, method: :get do
    csv = CsvDb.export(resource, :rehearsal_orders, json_options: { only: %i[block order], methods: [:song_title, :page, :role_list] }, assoc_preload: [:burm_song], order: [:block, :order])

    respond_to do |format|
      format.csv { send_data csv, filename: "#{resource.title.parameterize}-songs.csv" }
    end
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
      f.input :fee
      f.input :signup_start_at
      f.input :roles_assigned_at
      f.input :published_at
      f.input :roles_broadcasted_at
      f.input :signup_broadcasted_at
      f.input :excerpt_url
      f.input :schedule_url
      f.input :songlist_url
      f.input :checkin_instructions
      f.input :additional_joining_info
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

    f.input :location_name
    f.input :location
    f.inputs "Address" do
      f.has_many :address, heading: false, allow_destroy: true, new_record: false do |a|
        a.input :id, as: :hidden
        a.input :address, input_html: { rows: 3 }
        a.input :lat
        a.input :lon
        a.input :boundingbox, input_html: { rows: 3 }
        a.input :direction_notes, input_html: { rows: 3 }
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

    if f.object.new_record? || f.object.songs.blank?
      f.inputs :bulk_songs, as: :text, label: "Songs", hint: "Enter one song per line 1. Title"
    else
      f.inputs "Songs" do
        f.has_many :songs, heading: false, allow_destroy: true do |r|
          r.input :id, as: :hidden
          r.input :title
        end
      end
    end
    f.actions
  end
end

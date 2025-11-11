# frozen_string_literal: true

ActiveAdmin.register BURM::Musical do
  form partial: "form"
  permit_params :title, :start_at, :quote, :end_at, :location_name, :location, :fee,
                :bulk_roles, :bulk_songs, :signup_start_at, :roles_assigned_at,
                :published_at, :roles_sent_at, :signup_sent_at,
                :excerpt_url, :schedule_url, :songlist_url,
                :checkin_instructions, :additional_joining_info,
                roles_attributes: [:id, :name, :voice_type, :role_type, :_destroy],
                address_attributes: [:id, :address, :lat, :lon, :boundingbox, :direction_notes, :_destroy],
                image_attributes: [:id, :cid, :kind, :image],
                songs_attributes: [:id, :title, :page_number, :_destroy, role_ids: []],
                rehearsal_orders_attributes: [:id, :block, :order, :burm_song_id, :_destroy]

  # Broadcast
  member_action :broadcast, method: :put do
    resource.broadcast if Rails.env.production?
    redirect_to resource_path(resource), notice: "Broadcasted!"
  end

  # Test Broadcast
  member_action :broadcast_test, method: :put do
    resource.broadcast(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted!"
  end

  member_action :broadcast_preview, method: :put do
    @mail = Mailers::MusicalsMailerParser.mailer_compose(resource, current_user, :next_musical).html_part.decoded.html_safe
    render :mail_preview
  end

  # Signup Broadcast
  member_action :signup_broadcast, method: :put do
    resource.broadcast_signup if Rails.env.production?
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
  end

  # Test Signup Broadcast
  member_action :test_signup_broadcast, method: :put do
    resource.broadcast_signup(test: true)
    redirect_to resource_path(resource), notice: "Test Broadcasted Signup!"
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

  # Test Broadcast Joining Instructions
  member_action :preview_joining_instructions, method: :get do
    @mail = Mailers::MusicalsMailerParser.mailer_compose(resource, current_user, :joining_instructions).html_part.decoded.html_safe
    # resource.broadcast_joining_instructions(test: true)
    # redirect_to resource_path(resource), notice: "Broadcasted Joining Instructions!"
    render :mail_preview
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

  member_action :duplicate, method: :get do
    new_musical = resource.dup
    new_musical.title = "Copy of " + resource.title
    new_musical.published_at = nil
    new_musical.roles_assigned_at = nil
    new_musical.roles_sent_at = nil
    new_musical.signup_sent_at = nil
    new_musical.save!
    redirect_to edit_admin_burm_musical_path(new_musical), notice: "Musical duplicated. Please review details."
  end

  action_item :duplicate, only: :show do
    link_to "Duplicate Musical", duplicate_admin_burm_musical_path(resource), class: "action-item-button"
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

  member_action :broadcast_assignments, method: :put do
    if resource.excerpt_url.present?
      resource.broadcast_roles if Rails.env.production?
    else
      redirect_to resource_path(resource), alert: "Excerpt URL is missing!"
    end
  end

  member_action :broadcast_assignments_test, method: :put do
    resource.broadcast_roles(test: true)
    redirect_to resource_path(resource), notice: "Test Roles Broadcasted!"
  end

  member_action :broadcast_assignments_preview, method: :put do
    @mail = Mailers::MusicalsMailerParser.mailer_compose(resource, current_user, :role_assignments).html_part.decoded.html_safe
    render :mail_preview
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

  sidebar :actions, only: %i[show edit]
end

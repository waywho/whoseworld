class Admin::MediasController < ApplicationController
  include SiteSetter

  before_action :set_site, only: %i[ index new ]
  before_action :set_admin_media, only: %i[ show edit update destroy ]

  # GET /admin/medias
  def index
    @medias = if @site
      @site.medias.all
    else
      Media.all
    end
  end


  # GET /admin/medias/new
  def new
    @media = Media.new
  end

    # GET /admin/pages/1
  def show
    render :edit
  end

  # GET /admin/medias/1/edit
  def edit
  end

  # POST /admin/medias
  def create
    @media = Media.new(media_params)

    if @media.save
      redirect_to admin_medias_path, notice: "Media was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/medias/1
  def update
    if @media.update(media_params)
      redirect_to admin_medias_path, notice: "Media was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/medias/1
  def destroy
    @media.destroy
    redirect_to admin_medias_url, notice: "Media was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_media
      @media = Media.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def media_params
      params.require(:media).permit(:title, :source, :media_type, :page_id)
    end
end

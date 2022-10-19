class Admin::GalleriesController < AdminController
  include Imageable
  before_action :set_admin_gallery, only: %i[ show edit update destroy delete_image ]

  # GET /admin/galleries
  def index
    @galleries = Gallery.all
  end

  # GET /admin/galleries/1
  def show
  end

  # GET /admin/galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /admin/galleries/1/edit
  def edit
  end

  # POST /admin/galleries
  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to admin_galleries_path, notice: "Gallery was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/galleries/1
  def update
    if @gallery.update(gallery_params.slice(:title, :description, :page_id, :feature))
      @gallery.images.attach(gallery_params[:images]) if gallery_params[:images]
      redirect_to admin_galleries_path, notice: "Gallery was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/galleries/1
  def destroy
    @gallery.destroy
    redirect_to admin_galleries_url, notice: "Gallery was successfully destroyed."
  end

  def delete_image
    purge_image(params[:image_id])
    redirect_to admin_gallery_path(@gallery)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gallery_params
       params.require(:gallery).permit(:title, :description, :feature, :page_id, :images => [])
    end
end

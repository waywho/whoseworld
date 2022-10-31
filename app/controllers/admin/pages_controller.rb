class Admin::PagesController < AdminController
  include SiteSetter

  before_action :set_site, only: %i[ index new ]
  before_action :set_page, only: %i[ show edit destroy ]

  # GET /admin/pages
  def index
    @pages = if @site
      @site.pages.rank(:row_order).all
    else
      Page.rank(:row_order).all
    end
  end

  # GET /admin/pages/new
  def new
    @page = Page.new(site_id: @site&.id)
  end


  # GET /admin/pages/1
  def show
    redirect_to edit_admin_page_path
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to admin_pages_path, notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    site_id = page_params[:site_id] || params[:site_id]
    site = Site.find(site_id)
    @page = site.pages.friendly.find(params[:id])
    if @page.update(page_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_pages_path, notice: "Page was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/pages/1
  def destroy
    @page.destroy
    redirect_to admin_pages_url, notice: "Page was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:title, :menu, :template, :site_id, :row_order_position,
                            :feature, contents_attributes: %i[id body heading summary image page_id _destroy])
  end
end

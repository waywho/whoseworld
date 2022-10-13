class Admin::PagesController < AdminController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /admin/pages
  def index
    @pages = Page.rank(:row_order).all
  end

  # GET /admin/pages/new
  def new
    @page = Page.new
    @page.contents.build
  end


  # GET /admin/pages/1
  def show
    redirect_to edit_admin_page_path
  end

  # GET /admin/pages/1/edit
  def edit
    @page.contents.build
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
    if @page.update(page_params)
      respond_to do |format|
        # format.turbo_stream
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
                                   contents_attributes: %i[id body page_id])
    end
end

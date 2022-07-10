class Admin::PagesController < AdminController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /admin/pages
  def index
    @pages = Current.tenant.pages.all
  end

  # GET /admin/pages/new
  def new
    @page = Current.tenant.pages.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages
  def create
    @page = Current.tenant.pages.new(page_params)

    if @page.save
      redirect_to admin_pages_path, notice: "Page was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/pages/1
  def update
    if @page.update(page_params)
      redirect_to @page, notice: "Page was successfully updated."
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
      @page = Current.tenant.pages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :content, :menu, :site_id)
    end
end

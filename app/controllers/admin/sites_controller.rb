class Admin::SitesController < AdminController
  before_action :set_admin_site, only: %i[ show edit update destroy ]

  # GET /admin/sites
  def index
    @sites = Site.all
  end

  # GET /admin/sites/1
  def show
    render :edit
  end

  # GET /admin/sites/new
  def new
    @site = Site.new
    @site.domain_aliases.build
  end

  # GET /admin/sites/1/edit
  def edit
  end

  # POST /admin/sites
  def create
    @site = Site.new(site_params)

    if @site.save
      redirect_to admin_sites_url, notice: "Site was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/sites/1
  def update
    if @site.update(site_params)
      redirect_to admin_sites_url, notice: "Site was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/sites/1
  def destroy
    @site.destroy
    redirect_to admin_sites_url, notice: "Site was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_site
      @site = Site.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def site_params
      params.require(:site).permit(:name, :subdomain, :domain, :orientation, :slug, :subtitle)
    end
end

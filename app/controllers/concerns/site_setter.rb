module SiteSetter
  extend ActiveSupport::Concern

  private

  def set_site
    @site = Site.find(params[:site_id])
    # Current.tenant = @site
  end
end

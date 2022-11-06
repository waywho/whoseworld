module SiteSetter
  extend ActiveSupport::Concern

  private

  def set_site
    if params[:site]
      @site = Site.find_by(slug: params[:site])
      # Current.tenant = @site
    elsif Current.tenant
      @site = Current.tenant
    end
  end
end

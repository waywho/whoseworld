module SiteSetter
  extend ActiveSupport::Concern

  private

  def set_site
    if params[:site]
      @site = Site.find_by(slug: params[:site])
    elsif Current.site
      @site = Current.site
    end
  end
end

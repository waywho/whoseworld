module SiteSetter
  extend ActiveSupport::Concern

  included do
    before_action :set_site
  end

  private

  def set_site
    set_dev_tenant and return if Rails.env.development?

    Rails.logger.info "Request host: #{request.host}"
    Rails.logger.info "Request Domain: #{request.domain}"

    Current.tenant = Site.find_by_domain(current_domain) or not_found
    Current.layout = Current.tenant&.layout_style || :multi_page
  end

  def current_domain
    if request.domain == "co.uk"
      Rails.logger.info "Request Domain(2): #{request.domain(2)}"
      request.domain(2)
    else
      request.domain
    end
  end

  def set_dev_tenant
    domain = request&.domain&.split(".")[0]
    return unless domain
    
    Rails.logger.info "Dev Request host: #{request.host}"
    Rails.logger.info "Dev Request domain: #{domain}"

    Current.tenant = Site.where("domain LIKE ?", "%#{domain}%").first or not_found
    Current.layout = Current.tenant&.layout_style || :multi_page
  end

  def not_found
    raise ActionController::RoutingError, "Not Found"
  end
end

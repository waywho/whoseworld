module SiteSetter
  extend ActiveSupport::Concern

  included do
    before_action :set_site
  end

  private

  def set_site
    Rails.logger.info "Request host: #{request.host}"
    Rails.logger.info "Request Domain: #{request.domain}"

    set_dev_tenant and return if Rails.env.development?

    Current.tenant = Site.find_by_domain(current_domain)
    Current.layout = Current.tenant&.template_style || :multi_page
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
    domain = request.domain.split(".")[0]
    Rails.logger.info "Dev domain: #{domain}"
    Current.tenant = Site.where("domain LIKE ?", "%#{domain}%").first
    Current.layout = Current.tenant&.template_style || :multi_page
  end
end

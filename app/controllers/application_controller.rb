class ApplicationController < ActionController::Base
  before_action :set_site

  private

  def set_site
    Rails.logger.info "Request host: #{request.host}"
    Rails.logger.info "Request Domain: #{request.domain}"

    Current.tenant = if Rails.env.development?
      domain = request.domain.split(".")[0]
      domain = "weihsihu" if domain == "localhost"
      Site.where("domain LIKE ?", "%#{domain}%").first
    else
      if site = Site.find_by(domain: current_domain)
        site
      elsif domain_alias = DomainAlias.find_by(domain: current_domain)
        domain_alias.site
      end
    end

    Current.style = Current.tenant&.template_style || :multi_page
  end

  def current_domain
    if request.domain == "co.uk"
      Rails.logger.info "Request Domain(2): #{request.domain(2)}"
      request.domain(2)
    else
      request.domain
    end
  end
end

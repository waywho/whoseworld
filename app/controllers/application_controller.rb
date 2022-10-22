class ApplicationController < ActionController::Base
  before_action :set_site

  private

  def set_site
    Rails.logger.info "Request Domain: #{request.host}"
    Current.tenant = if Rails.env.development?
      domain = request.domain.split(".")[0]
      domain = "weihsihu" if domain == "localhost"
      site = Site.where("domain LIKE ?", "%#{domain}%").first
    else
      unless site = Site.find_by(domain: current_domain)
        domain_alias = DomainAlias.find_by(domain: current_domain)
        site = domain_alias.site if domain_alias
      end
      site
    end

    Current.style = Current.tenant&.template_style || :multi_page
  end

  def current_domain
    request.host
  end
end

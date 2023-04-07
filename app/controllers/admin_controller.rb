class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_site

  layout 'application'

  def set_site
    @site = Site.find(params[:site_id])
    # Current.tenant = @site
  end

  def set_current_site
    Rails.logger.info "Request host: #{request.host}"
    Rails.logger.info "Request Domain: #{request.domain}"

    set_dev_tenant and return if Rails.env.development?

    Current.tenant = if site = Site.find_by(domain: current_domain)
      site
    elsif domain_alias = DomainAlias.find_by(domain: current_domain)
      domain_alias.site
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

  def set_dev_tenant
    domain = request.domain.split(".")[0]
    Rails.logger.info "Dev domain: #{domain}"
    Current.tenant = Site.where("domain LIKE ?", "%#{domain}%").first
    Current.style = Current.tenant&.template_style || :multi_page
  end
end

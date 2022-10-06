class ApplicationController < ActionController::Base
  before_action :set_site

  private

  def set_site
    Current.tenant = if Rails.env.development?
      domain = request.domain.split(".")[0]
      domain = "weihsihu" if domain == "localhost"
      site = Site.where("domain LIKE ?", "%#{domain}%").first
    else
      domain = request.domain
      unless site = Site.find_by(domain: domain)
        domain_alias = DomainAlias.find_by(domain: domain)
        site = domain_alias.site if domain_alias
      end
    end

    Current.style = Current.tenant&.template_style || :multi_page
  end

  # def current_domain
  #   request.domain.split(".")[0]
  # end
end

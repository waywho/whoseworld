class ApplicationController < ActionController::Base
  before_action :production_redirect
  before_action :set_site

  private

  def production_redirect
    if Rails.env.production?
      render "pages/landing"
    end
  end

  def set_site
    if Rails.env.development?
      domain = request.domain.split(".")[0]
      site = Site.where("domain LIKE ?", "%#{domain}%").first
    else
      domain = request.domain
      site = Site.find_by(domain: domain)
    end
    Current.tenant = site
    if Current.tenant.slug == "weihsihu"
      Current.style = :one_page
    else
      Current.style = :multi_page
    end
  end
end

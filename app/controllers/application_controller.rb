class ApplicationController < ActionController::Base
  before_action :production_redirect
  before_action :set_site

  private

  def production_redirect
    if Rails.env.production? && !request.path.include?("admin")
      render "pages/landing", layout: 'application'
    end
  end

  def set_site
    Current.tenant = if Rails.env.development?
      domain = request.domain.split(".")[0]
      domain = "weihsihu" if domain == "localhost"
      site = Site.where("domain LIKE ?", "%#{domain}%").first
    else
      domain = request.domain
      site = Site.find_by(domain: domain)
    end

    if Current.tenant&.slug == "weihsihu"
      Current.style = :one_page
    else
      Current.style = :multi_page
    end
  end

  def current_domain
    request.domain.split(".")[0]
  end
end

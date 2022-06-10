class ApplicationController < ActionController::Base
  # before_action :production_redirect
  set_current_tenant_through_filter
  before_action :set_site


  private

  def production_redirect
    if Rails.env.production?
      render "pages/landing"
    end
  end

  def set_site
    if Rails.env.production?
      set_current_tenant_by_subdomain_or_domain(:site, :subdomain, :domain)
    else
      domain_name = request.domain.split(".")[0]
      current_site = Site.where("headline ILIKE ?", "%#{domain_name}%")
      set_current_tenant(current_account)
    end
  end

end

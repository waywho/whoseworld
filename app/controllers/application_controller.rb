class ApplicationController < ActionController::Base
  before_action :production_redirect
  before_action :set_site_name

  private

  def production_redirect
    if Rails.env.production?
      render "pages/landing"
    end
  end

  def set_site_name
    @site_name = nil
  end
end

class ApplicationController < ActionController::Base
  before_action :production_redirect

  private

  def production_redirect
    if Rails.env.production?
      render "pages/landing"
    end
  end
end

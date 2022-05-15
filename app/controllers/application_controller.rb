class ApplicationController < ActionController::Base
  before_action :production_redirect

  private

  def production_redirect
    if Rails.env.production?
      redirect_to root_path
    end
  end
end

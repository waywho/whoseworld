class ApplicationController < ActionController::Base
  include DevRedirect

  private

  def dev_redirect
    if Rails.env.production?
      redirect_to root_path
    end
  end
end

class SiteBaseController < ActionController::Base
  include SiteSetter
  layout "site"

  before_action :set_current_user

  private

  def set_current_user
    Current.user = current_user if user_signed_in?
  end
end

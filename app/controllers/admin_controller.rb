class AdminController < ActionController::Base
  include SiteSetter

  before_action :authenticate_user!
  before_action :set_site

  layout 'application'
end

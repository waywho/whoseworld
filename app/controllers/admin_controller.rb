class AdminController < ActionController::Base
  include SiteSetter
  
  before_action :authenticate_user!

  layout 'application'
end

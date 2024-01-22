class ApplicationController < ActionController::Base
  include SiteSetter

  before_action :set_site
end

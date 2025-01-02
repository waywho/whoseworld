class SiteBaseController < ActionController::Base
  include SiteSetter
  layout "site"
end

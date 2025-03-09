class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def helpers
    ActionController::Base.helpers
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end

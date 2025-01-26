class Current < ActiveSupport::CurrentAttributes
  attribute :tenant, :layout, :admin_site, :user
end

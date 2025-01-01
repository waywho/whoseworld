module SiteScopes
  extend ActiveSupport::Concern

  included do
    Site.all.each do |site|
      scope site.symbolized_slug, -> { where(site_id: site.id) }
    end
  end
end

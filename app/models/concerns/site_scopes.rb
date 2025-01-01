module SiteScopes
  extend ActiveSupport::Concern

  included do
    Site.all.each do |site|
      scope site.slug.to_sym, -> { where(site_id: site.id) }
    end
  end
end

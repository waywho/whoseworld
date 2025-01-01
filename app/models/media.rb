class Media < ApplicationRecord
  include SiteScopes

  belongs_to :page
  belongs_to :site, optional: true

  def self.types
    %i[video audio]
  end
end

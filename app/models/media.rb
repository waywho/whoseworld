class Media < ApplicationRecord
  include SiteScopes

  # Associations
  belongs_to :page, optional: true
  belongs_to :site, optional: true

  # Enums
  enum :media_type, %i[audio video], validation: true

  def self.types
    %i[audio video]
  end
end

class Media < ApplicationRecord
  include SiteScopes
  include Menuable

  # Associations
  belongs_to :page, optional: true
  belongs_to :site, optional: true

  # Enums
  enum :media_type, %i[audio video], validation: true

  # TODO: Remove
  def self.types
    %i[audio video]
  end
end

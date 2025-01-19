class MenuItem < ApplicationRecord
  include SiteScopes
  include RankedModel
  ranks :row_order, with_same: :site_id

  # Associations
  belongs_to :page, optional: true
  belongs_to :site

  # Validations
  validates :name, presence: true, uniqueness: { scope: :site_id }
  validates :url, presence: true, unless: -> { page.present? }
  validates :page, presence: true, unless: -> { url.present? }

  # Scopes
  default_scope { rank(:row_order) }
end

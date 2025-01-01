class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :site

  include Sluggable
  include SiteScopes
  include RankedModel
  ranks :row_order, with_same: :site_id

  # Associations
  has_many :galleries
  has_one :featured_gallery, -> { where(feature: true) }, class_name: "Gallery"
  has_many :medias
  belongs_to :site
  has_many :contents
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                           reject_if: proc { |attributes| attributes["body"].blank? && attributes["summary"].blank? }

  # Validations
  validates :title, presence: true, uniqueness:  { scope: :site_id }

  # Scopes
  scope :menu_pages, -> { where.not(title: "landing").where(menu: true) }
  scope :landing, -> { friendly.find("landing") }
  scope :feature, -> { where(feature: true) }

  # Attachment
  has_one_attached :feature_image

  def self.templates
    %i[plain gallery media]
  end

  def title_with_site
    "#{title} (#{site&.slug})"
  end
end

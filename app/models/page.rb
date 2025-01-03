class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :site

  include Sluggable
  include SiteScopes
  include RankedModel
  ranks :row_order, with_same: :site_id

  # Associations
  has_many :galleries, dependent: :nullify
  has_one :featured_gallery, -> { where(feature: true) }, class_name: "Gallery"
  has_many :medias, dependent: :nullify
  belongs_to :site
  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                           reject_if: proc { |attributes| attributes["body"].blank? && attributes["summary"].blank? }

  # Attachment
  has_one_attached :feature_image

  # Enums
  enum :template, %i[plain gallery media], validation: true

  # Validations
  validates :title, presence: true, uniqueness:  { scope: :site_id }

  # Scopes
  scope :menu_pages, -> { where.not(title: "landing").where(menu: true) }
  scope :landing, -> { friendly.find("landing") }
  scope :feature, -> { where(feature: true) }
end

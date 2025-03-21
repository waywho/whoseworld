class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :site

  include Sluggable
  include SiteScopes
  include RankedModel
  include Menuable
  ranks :row_order, with_same: :site_id

  KIND_LABELS = {
    non_menu: "Pages not to be displayed",
    imprint: "Imprint",
    feature: "Feature in Landing",
    menu: "Menu Pages",
    landing: "Landing"
  }

  # Associations
  has_many :galleries, dependent: :nullify
  has_one :featured_gallery, -> { where(feature: true) }, class_name: "Gallery"
  has_many :medias, dependent: :nullify
  belongs_to :site
  has_many :contents, as: :contentable, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                           reject_if: proc { |attributes| attributes["body"].blank? && attributes["summary"].blank? }
  has_one :feature_image, as: :imageable, class_name: "Image", dependent: :destroy
  accepts_nested_attributes_for :feature_image, allow_destroy: true

  # Scopes
  default_scope { rank(:row_order) }

  # Enums
  enum :template, %i[plain gallery media], validation: true
  enum :kind, %i[non_menu imprint feature menu landing], validation: true

  # Validations
  validates :title, presence: true, uniqueness:  { scope: :site_id }
  validate :unqie_landing_page, if: -> { landing? }

  # Callbacks
  after_commit :add_to_menu, on: %i[update create], if: -> { menu? }

  private

  def unqie_landing_page
    errors.add(:kind, "already exists") if site.pages.landing.exists?
  end
end

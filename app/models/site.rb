class Site < ApplicationRecord
  nilify_blanks
  include Sluggable

  # Associations
  has_many :pages, dependent: :destroy
  has_one :landing_page, ->{  where("slug ILIKE ?", "%landing%") }, class_name: "Page"
  has_many :domain_aliases, dependent: :destroy
  has_many :contents, as: :contentable, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                reject_if: proc { |attributes| attributes["heading"].blank? }
  accepts_nested_attributes_for :domain_aliases, allow_destroy: true,
                                reject_if: proc { |attributes| attributes["domain"].blank? && attributes["subdomain"].blank? }

  # Enums
  enum :nav_position, %i[top left right], validation: true
  enum :layout_style, %i[one_page multi_page], validation: true

  # Attachment
  has_one_attached :logo

  # Validations
  validates :domain, uniqueness: true, allow_nil: true

  # Scopes
  scope :find_by_domain, ->(domain) { includes(:domain_aliases).where(domain:).or(where(domain_aliases: { domain: })).take }

  after_create_commit :create_standard_contents
  before_save :slugify
  after_create_commit :create_landing_page

  # TODO: Remove
  def self.orientations
    %i[top left right].freeze
  end

  # TODO: Remove
  def self.site_styles
    %i[one_page multi_page].freeze
  end

  private

  def create_standard_contents
    contents.upsert_all([
      { heading: "Imprint" },
      { heading: "Privacy Policy" },
      { heading: "Terms of Service" }
    ])
  end

  def create_landing_page
    pages.create(title: "Landing", slug: "landing", menu: false, template: :plain)
  end
end

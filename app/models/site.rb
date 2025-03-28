class Site < ApplicationRecord
  nilify_blanks
  include Sluggable

  # Associations
  has_many :menu_items, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_one :landing_page, ->{  where(kind: :landing) }, class_name: "Page"
  has_many :domain_aliases, dependent: :destroy
  has_many :contents, as: :contentable, dependent: :destroy
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                reject_if: proc { |attributes| attributes["heading"].blank? }
  accepts_nested_attributes_for :domain_aliases, allow_destroy: true,
                                reject_if: proc { |attributes| attributes["domain"].blank? && attributes["subdomain"].blank? }

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  %i[logo logo_for_dark logo_with_tag logo_with_tag_for_dark].each do |method|
    has_one method, ->(site) { where(kind: method.to_s) }, class_name: "Image", as: :imageable
    accepts_nested_attributes_for method, allow_destroy: true, reject_if: proc { |attributes| attributes["image"].blank? }
  end

  # Enums
  enum :nav_position, %i[top left right], validation: true
  enum :layout_style, %i[one_page multi_page], validation: true

  # Validations
  validates :domain, uniqueness: true, allow_nil: true

  # Scopes
  scope :find_by_domain, ->(domain) { includes(:domain_aliases).where(domain:).or(where(domain_aliases: { domain: })).take }

  before_save :slugify
  after_create_commit :create_default_pages

  # TODO: Remove
  def self.orientations
    %i[top left right].freeze
  end

  # TODO: Remove
  def self.site_styles
    %i[one_page multi_page].freeze
  end

  private

  def create_default_pages
    [
      { title: "#{slug} Landing", kind: :landing, template: :plain },
      { title: "Imprint", kind: :imprint, template: :plain },
      { title: "Terms of Service", kind: :imprint, template: :plain },
      { title: "Privacy Policy", kind: :imprint, template: :plain },
    ].each do |page|
      pages.create(page)
    end
  end
end

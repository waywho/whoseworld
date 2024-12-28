class Site < ApplicationRecord
  validates :domain, uniqueness: true, allow_nil: true

  scope :find_by_domain, ->(domain) { includes(:domain_aliases).where(domain:).or(where(domain_aliases: { domain: })).take }

  has_many :pages, dependent: :destroy
  has_one :landing_page, ->{  where(slug: "landing") }, class_name: "Page"
  has_many :domain_aliases, dependent: :destroy
  accepts_nested_attributes_for :domain_aliases, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['domain'].blank? && attributes['subdomain'].blank? }
  has_one_attached :logo

  after_create_commit :create_landing_page

  def self.orientations
    %i[top left right].freeze
  end

  def self.site_styles
    %i[multi_page one_page].freeze
  end

  private

  def create_landing_page
    pages.create(title: "Landing", slug: "landing", menu: false, template: "landing")
  end
end

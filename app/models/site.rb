class Site < ApplicationRecord
  validates :domain, uniqueness: true, allow_nil: true

  has_many :pages
  has_one :landing_page, ->{  where(slug: "landing") }, class_name: "Page"
  has_many :domain_aliases
  accepts_nested_attributes_for :domain_aliases, allow_destroy: true,
                                reject_if: proc { |attributes| attributes['domain'].blank? && attributes['subdomain'].blank? }
  has_one_attached :logo

  def self.orientations
    %i[top left right].freeze
  end

  def self.site_styles
    %i[multi_page one_page]
  end
end

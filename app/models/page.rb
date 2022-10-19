class Page < ApplicationRecord
  extend FriendlyId
  include RankedModel
  ranks :row_order, with_same: :site_id
  # Associations
  has_many :galleries
  has_many :medias
  belongs_to :site
  has_many :contents
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                           reject_if: proc { |attributes| attributes['body'].blank? }

  friendly_id :title, use: :scoped, scope: :site

  validates :title, presence: true, uniqueness:  { scope: :site_id }

  scope :menu_pages, -> { where.not(title: "landing").where(menu: true) }
  scope :landing, -> { friendly.find("landing") }
  scope :feature, -> { where(feature: true) }

  def self.templates
    %i[plain gallery media]
  end

  def title_with_site
    "#{title} (#{site&.slug})"
  end
end

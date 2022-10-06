class Page < ApplicationRecord
  extend FriendlyId
  include RankedModel
  ranks :row_order, with_same: :site_id

  friendly_id :title, use: :slugged

  validates :title, presence: true, uniqueness:  { scope: :site_id }

  scope :menu_pages, -> { where.not(title: "landing").where(menu: true) }
  scope :landing, -> { friendly.find("landing") }

  # Associations
  has_many :galleries
  belongs_to :site
  has_many :contents
  accepts_nested_attributes_for :contents, allow_destroy: true,
                                           reject_if: proc { |attributes| attributes['body'].blank? }

  def self.templates
    %i[plain gallery media]
  end
end

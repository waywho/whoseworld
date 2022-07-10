class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :site

  validates :title, presence: true, uniqueness:  { scope: :site_id }

  scope :menu_pages, -> { where.not(title: "landing").where(menu: true) }
  scope :landing, -> { friendly.find("landing") }
end

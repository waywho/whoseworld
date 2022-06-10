class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_tenant :site
  validates_uniqueness_to_tenant :title
end

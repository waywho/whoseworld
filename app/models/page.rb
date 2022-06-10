class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_tenant :site
end

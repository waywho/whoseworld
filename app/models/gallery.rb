class Gallery < ApplicationRecord
  # Associations
  belongs_to :page, optional: true
  has_many_attached :images

  # Scopes
  scope :featured, -> { where(feature: true).first }
  scope :not_featured, -> { where.not(feature: true).first }
end

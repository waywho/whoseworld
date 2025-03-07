class Gallery < ApplicationRecord
  include Menuable
  
  # Associations
  belongs_to :page, optional: true
  has_many_attached :images
  has_many :gallery_images, as: :imageable, class_name: "Image", dependent: :destroy
  accepts_nested_attributes_for :gallery_images, allow_destroy: true

  # Scopes
  scope :featured, -> { where(feature: true).first }
  scope :not_featured, -> { where.not(feature: true).first }
end

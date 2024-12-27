class Content < ApplicationRecord
  nilify_blaks
  
  belongs_to :page
  has_one_attached :image
end

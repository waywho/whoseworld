class Content < ApplicationRecord
  nilify_blanks
  
  belongs_to :page
  has_one_attached :image
end

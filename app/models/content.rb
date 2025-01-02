class Content < ApplicationRecord
  nilify_blanks
  include RankedModel
  ranks :row_order, with_same: :page_id

  # Associations
  belongs_to :page
  has_one_attached :image
end

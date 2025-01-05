class Content < ApplicationRecord
  nilify_blanks
  include RankedModel
  ranks :row_order, with_same: %i[record_id record_type]

  # Associations
  belongs_to :contentable, polymorphic: true
  has_one_attached :image

  # Validations
  validates :heading, presence: true
end

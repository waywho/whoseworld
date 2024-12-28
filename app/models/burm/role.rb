class Burm::Role < ApplicationRecord
  enum :voice_type, %i[speaking bass baritone tenor alto mezzo_soprano soprano], allow_nil: true, validate: true
  enum :type, %i[ensemble featured supporting lead], allow_nil: true, validate: true
  
  belongs_to :burm_show, class_name: "Burm::Show", foreign_key: "burm_show_id"

  validates :name, uniqueness: { scope: :burm_show }
end

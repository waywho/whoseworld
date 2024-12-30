class Burm::Role < ApplicationRecord
  enum :voice_type, %i[speaking bass baritone tenor alto mezzo_soprano soprano], allow_nil: true, validate: true
  enum :type, %i[ensemble featured supporting lead], allow_nil: true, validate: true
  
  belongs_to :show, class_name: "Burm::Show", foreign_key: "burm_show_id"
  has_many :signups, class_name: "Burm::Signup", foreign_key: "burm_role_id"

  validates :name, uniqueness: { scope: :show }
end

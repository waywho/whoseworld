class BURM::Role < ApplicationRecord
  include MusicalScopes

  enum :voice_type, %i[speaking bass baritone tenor alto mezzo_soprano soprano], allow_nil: true, validate: true
  enum :role_type, %i[ensemble featured supporting lead], validate: { allow_nil: true }, suffix: :role
  
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_role_id"

  validates :name, uniqueness: { scope: :musical }
end

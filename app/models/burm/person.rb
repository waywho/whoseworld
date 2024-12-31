class BURM::Person < ApplicationRecord
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_person_id"
  has_many :roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"
  has_many :musicals, through: :signups, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_many :alternative_roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"
end

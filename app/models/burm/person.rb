class Burm::Person < ApplicationRecord
  has_many :signups, class_name: "Burm::Signup", foreign_key: "burm_person_id"
  has_many :roles, through: :signups, class_name: "Burm::Role", foreign_key: "burm_role_id"
  has_many :musicals, through: :signups, class_name: "Burm::Musical", foreign_key: "burm_musical_id"
  has_many :alternative_roles, through: :signups, class_name: "Burm::Role", foreign_key: "burm_role_id"
end

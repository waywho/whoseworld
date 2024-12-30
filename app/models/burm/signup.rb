class Burm::Signup < ApplicationRecord
  belongs_to :person, class_name: "Burm::Person", foreign_key: "burm_person_id"
  belongs_to :role, class_name: "Burm::Role", foreign_key: "burm_role_id"
  belongs_to :musical, class_name: "Burm::Musical", foreign_key: "burm_musical_id"
  belongs_to :alternative_role, optional: true, class_name: "Burm::Role"
end

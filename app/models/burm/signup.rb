class BURM::Signup < ApplicationRecord
  belongs_to :person, class_name: "BURM::Person", foreign_key: "burm_person_id"
  belongs_to :role, class_name: "BURM::Role", foreign_key: "burm_role_id"
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  belongs_to :alternative_role, optional: true, class_name: "BURM::Role"

  accepts_nested_attributes_for :person, reject_if: :all_blank
end

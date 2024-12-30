class Burm::Signup < ApplicationRecord
  belongs_to :burm_person
  belongs_to :burm_role
  belongs_to :burm_show
  belongs_to :alternative_role, optional: true, class_name: "Burm::Role"
end

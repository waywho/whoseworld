class Burm::Person < ApplicationRecord
  has_many :signups, class_name: "Burm::Signup", foreign_key: "burm_person_id"
  has_many :roles, through: :signups, class_name: "Burm::Role", foreign_key: "burm_role_id"
  has_many :shows, through: :signups, class_name: "Burm::Show", foreign_key: "burm_show_id"
  has_many :alternative_roles, through: :signups, class_name: "Burm::Role", foreign_key: "burm_role_id"
end

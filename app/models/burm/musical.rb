class Burm::Musical < ApplicationRecord
  after_initialize :set_default_fee, unless: :persisted?

  has_many :roles, class_name: "Burm::Role", foreign_key: "burm_musical_id"
  has_many :signups, class_name: "Burm::Signup", foreign_key: "burm_musical_id"
  has_many :people, through: :signups, class_name: "Burm::Person", foreign_key: "burm_person_id"

  private

  def set_default_fee
    self.fee ||= 15.00
  end
end

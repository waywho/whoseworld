class BURM::Musical < ApplicationRecord
  after_initialize :set_default_fee, unless: :persisted?

  has_many :roles, class_name: "BURM::Role", foreign_key: "burm_musical_id"
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_musical_id"
  has_many :people, through: :signups, class_name: "BURM::Person", foreign_key: "burm_person_id"

  private

  def set_default_fee
    self.fee ||= 15.00
  end
end

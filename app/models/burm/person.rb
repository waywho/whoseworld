class BURM::Person < ApplicationRecord
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_person_id", dependent: :nullify
  has_many :roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"
  has_many :musicals, through: :signups, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_many :alternative_roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"

  accepts_nested_attributes_for :signups, allow_destroy: true, reject_if: proc { |attrs| attrs["burm_musical_id"].blank? }

  validates :first_name, :last_name, :email, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end

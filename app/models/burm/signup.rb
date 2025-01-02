class BURM::Signup < ApplicationRecord
  include MusicalScopes
  
  # Associations
  belongs_to :person, class_name: "BURM::Person", foreign_key: "burm_person_id"
  belongs_to :role, class_name: "BURM::Role", foreign_key: "burm_role_id"
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  belongs_to :alternative_role, optional: true, class_name: "BURM::Role"

  accepts_nested_attributes_for :person, reject_if: :all_blank

  # Validations
  validates :person, uniqueness: { scope: %i[role musical] }

  # Callbacks
  before_commit :set_cached_attributes, only: %i[create update]

  private

  def set_cached_attributes
    self.person_name = person&.full_name
    self.role_name = role&.name
    self.musical_title = musical&.title
  end
end

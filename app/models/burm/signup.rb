class BURM::Signup < ApplicationRecord
  nilify_blanks
  include MusicalScopes
  
  # Associations
  belongs_to :person, class_name: "BURM::Person", foreign_key: "burm_person_id", optional: true
  belongs_to :role, class_name: "BURM::Role", foreign_key: "burm_role_id", optional: true
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id", optional: true
  belongs_to :alternative_role, optional: true, class_name: "BURM::Role"

  accepts_nested_attributes_for :person, reject_if: :blank_or_invalid_person

  # Validations
  validate :association_or_cached
  validates :person, uniqueness: { scope: %i[role musical],
            message: "cannot sign up for the same musical twice" },
            if: -> { person.present? && role.present? && musical.present? }

  # Callbacks
  before_validation :find_or_build_person
  before_save :set_cached_attributes

  private

  def association_or_cached
    if person_name.nil? && person.nil?
      errors.add(:person, "must exist")
    end

    if role_name.nil? && role.nil?
      errors.add(:role, "must exist")
    end

    if musical_title.nil? && musical.nil?
      errors.add(:musical, "must exist")
    end
  end

  def find_or_build_person
    return if person.nil?

    person_record = BURM::Person.find_or_initialize_by(email: person&.email)

    if person_record.new_record?
      person_record.assign_attributes(person.attributes.slice("first_name", "last_name", "email"))
    end

    self.person = person_record
  end

  def blank_or_invalid_person(attributes)
    all_blank = attributes.all? { |key, value| key == "_destroy" || value.blank? }

    all_blank || !build_person(attributes).valid?
  end

  def set_cached_attributes
    self.person_name = person&.full_name
    self.role_name = role&.name
    self.musical_title = musical&.title
  end
end

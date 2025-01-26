class BURM::Signup < ApplicationRecord
  nilify_blanks
  include MusicalScopes
  self.implicit_order_column = "created_at"
  
  # Associations
  belongs_to :person, class_name: "BURM::Person", foreign_key: "burm_person_id", optional: true
  belongs_to :role, class_name: "BURM::Role", foreign_key: "burm_role_id", optional: true
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id", optional: true
  belongs_to :alternative_role, optional: true, class_name: "BURM::Role"

  accepts_nested_attributes_for :person, reject_if: :blank_or_invalid_person

  # Validations
  validates :commit_to_pay, acceptance: true
  validates :agree_to_emails, acceptance: true
  validate :musical_signup_open, on: :create
  validate :association_or_cached, on: :update
  validates :person, presence: true, on: :create
  validates :role, presence: true, on: :create
  validates :musical, presence: true, on: :create
  validates :person, uniqueness: { scope: %i[role musical],
            message: "cannot sign up for the same role and musical twice" },
            if: -> { person.present? && role.present? && musical.present? }

  # Callbacks
  before_validation :find_or_build_person
  before_save :set_cached_attributes
  before_save :set_cancelled_at, if: :cancelled?

  private

  def musical_signup_open
    return if Current.user&.admin?
    return if musical.nil? || musical.signup_open?

    errors.add(:musical, "is not open for signups")
  end

  def set_cancelled_at
    self.cancelled_at = Time.current
  end

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

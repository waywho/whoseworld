class BURM::Signup < ApplicationRecord
  nilify_blanks
  include MusicalScopes
  self.implicit_order_column = "created_at"
  
  # Associations
  belongs_to :person, class_name: "BURM::Person", foreign_key: "burm_person_id", optional: true
  belongs_to :role, class_name: "BURM::Role", foreign_key: "burm_role_id", optional: true
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id", optional: true
  belongs_to :alternative_role, optional: true, class_name: "BURM::Role"
  belongs_to :assigned_role, optional: true, class_name: "BURM::Role", foreign_key: "assigned_burm_role_id"

  accepts_nested_attributes_for :person

  # Validations
  validates :commit_to_pay, acceptance: true
  validates :agree_to_emails, acceptance: true
  validate :musical_signup_open, on: :create
  validate :association_or_cached, on: :update
  # only validate on :create because we cache the attributes
  validates :role, presence: true, on: :create
  validates :musical, presence: true, on: :create
  # validates :person, uniqueness: { scope: %i[role musical],
  #           message: "cannot sign up for the same role and musical twice" },
  #           if: -> { !cancelled || (person.present? && role.present? && musical.present?) },
  #           on: :create
  # validates :assigned_role, uniqueness: { scope: %i[musical]}
  # validate :unique_role_assignment

  # Callbacks
  before_validation :find_or_build_person, on: :create
  before_save :set_cached_attributes
  before_save :set_cancelled_at
  after_commit :set_assigned_role, on: :create
  after_commit :add_person_to_newsletter, on: :create

  private

  def unique_role_assignment
    return unless musical
    return if (musical.signups.pluck(:assigned_burm_role_id) - [assigned_burm_role_id_was]).exclude?(assigned_burm_role_id)

    errors.add(:assigned_burm_role_id, "this role has been assigned to another person.")
  end

  def set_assigned_role
    return if role.ensemble_role?

    if musical.signups.pluck(:assigned_burm_role_id).exclude?(burm_role_id)
      update(assigned_burm_role_id: burm_role_id)
    elsif musical.signups.pluck(:assigned_burm_role_id).exclude?(alternative_role_id)
      update(assigned_burm_role_id: burm_role_id)
    end
  end

  def add_person_to_newsletter
    person&.subscribe!
  end

  def musical_signup_open
    return if Current.user&.admin?
    return if musical.nil? || musical.signup_open?

    errors.add(:musical, "is not open for signups")
  end

  def set_cancelled_at
    if cancelled?
      self.cancelled_at = Time.current
    else
      self.cancelled_at = nil
    end
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

    person_record.confirmed_at = Time.current
    self.person = person_record
  end

  def blank_or_invalid_person(attributes)
    all_blank = attributes.except("_destroy").all? { |_key, value| value.blank? }

    all_blank || !build_person(attributes).valid?
  end

  def set_cached_attributes
    self.person_name = person&.full_name
    self.role_name = role&.name
    self.musical_title = musical&.title
  end
end

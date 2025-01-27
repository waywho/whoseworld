class BURM::Person < ApplicationRecord
  nilify_blanks

  # Associations
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_person_id", dependent: :nullify
  has_many :roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"
  has_many :musicals, through: :signups, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_many :alternative_roles, through: :signups, class_name: "BURM::Role", foreign_key: "burm_role_id"

  accepts_nested_attributes_for :signups, allow_destroy: true, reject_if: proc { |attrs| attrs["burm_musical_id"].blank? }

  # Validations
  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, presence: true
  validates :agree_to_terms, acceptance: true

  # Enums
  enum :voice_type, %i[dont_know soprano alto tenor baritone bass], validate: true

  # Callbacks
  after_commit :generate_confirmation_token, :set_confirmation, on: :create
  after_commit :set_agree_to_terms_at, :set_agree_to_emails_at, on: %i[create update]

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def set_confirmation
    update_columns(confirmed_at: Time.current) if signups.any?
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def set_agree_to_terms_at
    update_columns(agree_to_terms_at: Time.current) if agree_to_terms
  end

  def set_agree_to_emails_at
    update_columns(agree_to_emails_at: Time.current) if agree_to_emails
  end
end

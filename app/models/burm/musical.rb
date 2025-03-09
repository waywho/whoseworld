class BURM::Musical < ApplicationRecord
  nilify_blanks
  extend FriendlyId
  friendly_id :title, use: :slugged
  include Sluggable
  include Addressable
  include BURMHostable

  # Associations
  has_many :roles, class_name: "BURM::Role", foreign_key: "burm_musical_id",
           inverse_of: :musical, autosave: true, dependent: :destroy
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_musical_id", dependent: :nullify
  has_many :people, through: :signups, class_name: "BURM::Person", foreign_key: "burm_person_id"

  accepts_nested_attributes_for :roles, allow_destroy: true, reject_if: proc { |attrs| attrs[:name].blank? }
  has_one :image, as: :imageable, class_name: "Image", dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true

  # Attribute
  attribute :bulk_roles, :text

  # Callbacks
  after_initialize :set_default_fee, unless: :persisted?
  before_validation :build_from_bulk_roles

  def signup_open?
    signup_start_at&.past?
  end

  def signup_open_at
    "near future" unless signup_start_at

    signup_time = signup_start_at&.strftime("%A, %B %e, %Y at %l:%M %p")
    Time.zone.parse(signup_time.to_s).strftime("%A, %B %e, %Y at %l:%M %p")
  end

  def date
    start_at&.strftime("%A, %B %e, %Y")&.to_s
  end

  def time
    start_at_time = Time.zone.parse(start_at.to_s)
    end_at_time = Time.zone.parse(end_at.to_s)
    "#{start_at_time.strftime("%l:%M %p")} - #{end_at_time.strftime("%l:%M %p")}"
  end

  # could move to a decorator
  def signup_url
    url_helpers.new_burm_signup_url(self, host:)
  end

  def fee_with_currency(locale: :de)
    helpers.number_to_currency(fee, locale:)
  end

  # Actions
  def broadcast(test: false)
    MusicalMailJob.perform_later(:next_musical, self, test:)
  end

  def broadcast_signup(test: false)
    MusicalMailJob.perform_later(:signup_open, self, test:)
  end

  private

  def build_from_bulk_roles
    return if bulk_roles.blank?

    bulk_roles.split("\n").each do |line|
      name, role_type, voice_type = line.split(",").map(&:strip)
      voice_type = voice_type.gsub("(", "").gsub(")", "").downcase.to_sym if voice_type
      role_type = role_type.downcase.to_sym if role_type

      role = roles.build(name:, voice_type:, role_type:)
      roles.delete(role) unless role.valid?
    end

    roles
  end

  def set_default_fee
    self.fee = 15.00
  end
end

class BURM::Musical < ApplicationRecord
  nilify_blanks
  extend FriendlyId
  friendly_id :title, use: :slugged
  include Sluggable

  # Associations
  has_many :roles, class_name: "BURM::Role", foreign_key: "burm_musical_id",
           inverse_of: :musical, autosave: true, dependent: :destroy
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_musical_id", dependent: :nullify
  has_many :people, through: :signups, class_name: "BURM::Person", foreign_key: "burm_person_id"

  accepts_nested_attributes_for :roles, allow_destroy: true, reject_if: proc { |attrs| attrs[:name].blank? }

  # ActiveStorage
  has_one_attached :image

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

    signup_start_at&.strftime("%A, %B %e, %Y at %l:%M %p")
  end

  def date
    "#{start_at.strftime("%A, %B %e, %Y")}"
  end

  def time
    "#{start_at.strftime("%l:%M %p")} - #{end_at.strftime("%l:%M %p")}"
  end

  private

  def build_from_bulk_roles
    return if bulk_roles.blank?

    bulk_roles.split("\n").each do |line|
      name, voice_type, role_type = line.split(",").map(&:strip)
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

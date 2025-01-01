class BURM::Musical < ApplicationRecord
  after_initialize :set_default_fee, unless: :persisted?
  before_validation :build_from_bulk_roles

  has_many :roles, class_name: "BURM::Role", foreign_key: "burm_musical_id",
           inverse_of: :musical, autosave: true, dependent: :destroy
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_musical_id"
  has_many :people, through: :signups, class_name: "BURM::Person", foreign_key: "burm_person_id"

  accepts_nested_attributes_for :roles, allow_destroy: true, reject_if: proc { |attrs| attrs.valid? }

  attribute :bulk_roles, :text

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
  end

  def set_default_fee
    self.fee ||= 15.00
  end
end

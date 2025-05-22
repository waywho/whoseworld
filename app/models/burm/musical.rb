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

  has_many :songs, class_name: "BURM::Song", foreign_key: "burm_musical_id", dependent: :destroy
  accepts_nested_attributes_for :songs, allow_destroy: true, reject_if: proc { |attrs| attrs[:title].blank? && attrs[:role_ids].compact_blank!.blank? && attrs[:page_number].blank? }
  has_many :rehearsal_orders, class_name: "BURM::RehearsalOrder", foreign_key: "burm_musical_id"
  accepts_nested_attributes_for :rehearsal_orders, allow_destroy: true, reject_if: proc { |attrs| attrs[:burm_song_id].blank? }

  # Attribute
  attribute :bulk_roles, :text
  attribute :bulk_songs, :text

  # Callbacks
  after_initialize :set_default_fee, unless: :persisted?
  before_validation :build_from_bulk_roles, :build_from_bulk_songs

  def signup_open?
    signup_start_at&.past?
  end

  def signup_open_at
    "near future" unless signup_start_at

    signup_start_at&.strftime("%A, %B %e, %Y at %l:%M %p")
  end

  def date
    start_at&.strftime("%A, %B %e, %Y")&.to_s
  end

  def time
    "#{start_at.strftime("%l:%M %p")} -#{end_at.strftime("%l:%M %p")}"
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
    return if !test && published_at?

    MusicalMailJob.perform_later(:next_musical, self, mailer: "MusicalsMailer", test:)
    update_column(:published_at, Time.zone.now) unless test
  end

  def broadcast_signup(test: false)
    return if !test && signup_sent_at?

    MusicalMailJob.perform_later(:signup_open, self, test:)
    update_column(:signup_sent_at, Time.zone.now) unless test
  end

  def broadcast_roles(test: false)
    return if !test && roles_sent_at?

    send_signups = test ? User.where(admin: true) : signups.map(&:person)

    send_signups.each do |person|
      BURM::MusicalsMailer.with(musical: self, person:).role_assignments.deliver_later
    end
    update_column(:roles_sent_at, Time.zone.now) unless test
  end

  def broadcast_joining_instructions(test: false)
    return if !test && joining_instructions_sent_at?

    send_signups = test ? User.where(admin: true) : signups.map(&:person)

    send_signups.each do |person|
      BURM::MusicalsMailer.with(musical: self, person:).joining_instructions.deliver_later
    end
    update_column(:joining_instructions_sent_at, Time.zone.now) unless test
  end

  private

  def build_from_bulk_songs
    return if bulk_songs.blank?

    bulk_songs.split("\n").each do |line|
      order, title = line.split(".").map(&:strip)
      if order.to_i == 0
        title = order
        order = nil
      end
      song = songs.build(title:, order:)
      songs.delete(song) unless song.valid?
    end

    songs
  end

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

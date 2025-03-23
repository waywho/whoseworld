class BURM::Role < ApplicationRecord
  nilify_blanks
  include MusicalScopes

  # Associations
  belongs_to :musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_many :signups, class_name: "BURM::Signup", foreign_key: "burm_role_id", dependent: :nullify
  has_and_belongs_to_many :songs, class_name: "BURM::Song", join_table: "burm_songs_burm_roles", association_foreign_key: "burm_song_id", foreign_key: "burm_role_id"

  # Enums
  enum :voice_type, %i[speaking bass baritone tenor alto mezzo_soprano soprano satb], allow_nil: true, validate: true
  enum :role_type, %i[ensemble featured supporting lead], validate: { allow_nil: true }, suffix: :role
  
  # Validations
  validates :name, uniqueness: { scope: :musical }

  def to_s
    [name, voice_type].compact.join(" - ")
  end

  def assigned_to
    musical.signups.find_by(assigned_burm_role_id: id)&.person&.full_name
  end
end

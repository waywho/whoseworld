class BURM::Song < ApplicationRecord
  belongs_to :musical, optional: true, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  has_and_belongs_to_many :roles, class_name: "BURM::Role", join_table: "burm_songs_burm_roles", association_foreign_key: "burm_role_id", foreign_key: "burm_song_id"
  has_many :rehearal_orders, class_name: "BURM::RehearsalOrder", foreign_key: "burm_song_id", dependent: :destroy

  validates :title, presence: true

  def role_list
    roles.map(&:name).join(", ")
  end
end

class BURM::RehearsalOrder < ApplicationRecord
  belongs_to :burm_musical, class_name: "BURM::Musical", foreign_key: "burm_musical_id"
  belongs_to :burm_song, class_name: "BURM::Song", foreign_key: "burm_song_id"

  def song_title
    "#{burm_song.order}. #{burm_song.title}"
  end

  def page
    burm_song.page_number
  end

  def role_list
    burm_song.role_list
  end
end

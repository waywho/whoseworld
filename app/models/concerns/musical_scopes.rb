module MusicalScopes
  extend ActiveSupport::Concern

  included do
    BURM::Musical.all.each do |musical|
      scope musical.symbolized_slug, -> { where(burm_musical_id: musical.id) }
    end
  end
end

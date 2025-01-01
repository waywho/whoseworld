module MusicalScopes
  extend ActiveSupport::Concern

  included do
    BURM::Musical.all.each do |musical|
      scope musical.slug.to_sym, -> { where(burm_musical_id: musical.id) }
    end
  end
end

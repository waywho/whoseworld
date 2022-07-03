class Site < ApplicationRecord
  has_many :pages

  def self.orientations
    %i[top left right].freeze
  end
end

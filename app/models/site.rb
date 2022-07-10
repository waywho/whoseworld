class Site < ApplicationRecord
  validates :domain, uniqueness: true, allow_nil: true
  validates :subdomain, uniqueness: true, allow_nil: true

  has_many :pages

  def self.orientations
    %i[top left right].freeze
  end
end

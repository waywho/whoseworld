class Site < ApplicationRecord
  validates :domain, uniqueness: true, allow_nil: true
  validates :subdomain, uniqueness: true, allow_nil: true

  has_many :pages
  has_many :domain_aliases
  has_one_attached :logo

  def self.orientations
    %i[top left right].freeze
  end
end

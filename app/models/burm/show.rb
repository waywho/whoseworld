class Burm::Show < ApplicationRecord
  after_initialize :set_default_fee, unless: :persisted?

  private

  def set_default_fee
    self.fee ||= 15.00
  end
end

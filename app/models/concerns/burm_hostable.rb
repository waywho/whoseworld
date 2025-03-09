module BURMHostable
  extend ActiveSupport::Concern

  def host
    Rails.env.production? ? "berlinunrehearsedmusicals.com" : "berlinunrehearsedmusicals.test"
  end
end

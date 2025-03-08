class BURMMailer < ActionMailer::Base
  helper ImageHelper

  default from: "info@berlinunrehearsedmusicals.com"
  layout "burm/mailer"

  private

  def burm_subject(subject)
    "BURM | #{subject}"
  end
end

class BURMMailer < ActionMailer::Base
  default from: "info@berlinunrehearsedmusicals.com"
  layout "burm/mailer"

  private

  def burm_subject(subject)
    "BURM | #{subject}"
  end
end

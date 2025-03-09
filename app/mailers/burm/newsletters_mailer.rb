class BURM::NewslettersMailer < BURMMailer
  def new_subscription
    @person = params[:person]
    mail(to: @person.email,
         subject: burm_subject("Confirm your subscription!"),
         category: "new_subscription")
  end

  private

  def confirm_url(*params)
    host = Rails.env.production? ? "berlinunrehearsedmusicals.com" : "berlinunrehearsedmusicals.test"

    burm_newsletter_confirm_url(*params, host:)
  end
  helper_method :confirm_url
end

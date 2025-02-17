class BURM::NewslettersMailer < BURMMailer
  def new_subscription
    @person = params[:person]
    mail(to: @person.email,
         subject: burm_subject("Confirm your subscription!"))
  end
end

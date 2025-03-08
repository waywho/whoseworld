class BURM::MusicalsMailer < BURMMailer
  def next_musical
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("Our Next Musical...Oops"))
  end

  def signup_url(*params)
    host = Rails.env.production? ? "berlinunrehearsedmusicals.com" : "berlinunrehearsedmusicals.test"

    new_burm_signup_url(*params, host:)
  end
  helper_method :signup_url
end

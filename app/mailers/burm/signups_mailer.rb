class BURM::SignupsMailer < BURMMailer
  before_action :set_defaults

  def confirmation
    mail(to: @person.email,
         subject: burm_subject("You've signed up to #{@signup.musical.title}!"))
  end

  def confirm_update
    mail(to: @person.email,
         subject: burm_subject("You've updated the signup for #{@signup.musical.title}!"))
  end

  private

  def edit_signup_url(*params)
    host = Rails.env.production? ? "berlinunrehearsedmusicals.com" : "berlinunrehearsedmusicals.test"

    edit_burm_signup_url(*params, host:)
  end
  helper_method :edit_signup_url

  def set_defaults
    @signup = params[:signup]
    @musical = @signup.musical
    @person = @signup.person

    @cal = AddToCalendar::URLs.new(
        start_datetime: @musical.start_at,
        end_datetime: @musical.end_at,
        title: "Berlin UnRehearsed Musicals: #{@musical.title}",
        location: @musical.location,
        timezone: "Europe/Berlin"
      )
  end
end

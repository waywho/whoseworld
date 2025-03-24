class BURM::MusicalsMailer < BURMMailer
  def next_musical
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("Our Next Musical...Oops"),
         category: "next_musical")
  end

  def role_assignments
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("#{@musical.title} Roles & Music"),
           category: "role_assignments")
  end

  def joining_instructions
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("Joining Instructions for #{@musical.title}"),
         category: "joining_instructions")
  end

  def signup_url(*params)
    host = Rails.env.production? ? "berlinunrehearsedmusicals.com" : "berlinunrehearsedmusicals.test"

    new_burm_signup_url(*params, host:)
  end
  helper_method :signup_url
end

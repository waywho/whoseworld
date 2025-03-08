class BURM::MusicalsMailer < BURMMailer
  def next_musical
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("Our Next Musical..."))
  end
end

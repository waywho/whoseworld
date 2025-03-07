class BURM::MusicalsMailer < BURMMailer
  def announcement
    @musical = params[:musical]
    @person = params[:person]

    mail(to: @person.email,
         subject: burm_subject("Our Next Musical..."))
  end
end

class Mailers::MusicalsMailerParser
  def self.parse(musical, person, mail_method)
    composed_mail = mailer_compose(musical, person, mail_method)
    {
      to: [{
          email: person.email,
          name: person.full_name
        }],
      subject: composed_mail.subject,
      html: composed_mail.html_part.decoded.html_safe,
      text: composed_mail.text_part.decoded
    }
  end

  def self.mailer_compose(musical, person, mail_method)
    BURM::MusicalsMailer.with(musical:, person:).send(mail_method)
  end
end

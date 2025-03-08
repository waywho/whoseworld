class MusicalMailerService
  attr_reader :mailer, :mail_method, :category, :musical, :receivers, :sandbox
  def initialize(mailer, mail_method, musical:, receivers: nil, sandbox: Rails.env.development?)
    @mailer = mailer
    @category = "#{mailer.gsub('Mailer', '')} #{mail_method.to_s.camelcase}"
    @mail_method = mail_method
    @musical = musical
    @receivers ||= BURM::Person.subscribers
    @sandbox = sandbox
  end

  def send_mail
    client.send_batch(base_request, composed_mails)
  end

  private

  def base_request
    {
      from: {
        email: "weihsi@berlinunrehearsedmusicals.com",
        name: "WeiHsi Hu"
      },
      reply_to: {
        email: "info@berlinunrehearsedmusicals.com",
        name: "BURM Reply-To"
      },
      category: mail_method
    }
  end

  def composed_mails
    receivers.map do |person|
      composed_mail = mail(person)
      Mailtrap::Mail::Base.new(
        to: [{
          email: person.email,
          name: person.full_name
        }],
        subject: composed_mail.subject,
        html: composed_mail.html_part.decoded.html_safe,
        text: composed_mail.text_part.decoded
      )
    end
  end

  def mail(person)
    mailer.constantize.with(musical:, person:).send(mail_method)
  end

  def client
    @client ||= begin
      config = {
        api_key: Rails.application.credentials.mailtrap_api_token,
        sandbox:,
        inbox_id: Rails.application.credentials.mailtrap_inbox_id
      }.compact_blank

      ::BatchMailClient.new(**config)
    end
  end
end

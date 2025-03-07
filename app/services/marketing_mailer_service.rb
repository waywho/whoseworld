class MarketingMailerService
  attr_reader :mailer, :mail_method, :musical
  def initialize(mailer, mail_method, musical:)
    @mailer = mailer
    @mail_method = mail_method
    @musical = musical
    @person = BURM::Person.subscribers.first
  end

  def send_mail
    client.send(compose_mail)
  end

  private

  def compose_mail
    Mailtrap::Mail::Base.new(
      from: { email: "weihsi@berlinunrehearsedmusicals.com", name: "WeiHsi Hu" },
      to: BURM::Person.subscribers.map(&:to_mail_hash),
      reply_to: { email: "info@berlinunrehearsedmusicals.com", name: 'BURM Reply-To' },
      category: "Next Musical",
      subject: "BURM: Our Next Musical...",
      html: mail_body.html_part.decoded.html_safe,
      text: mail_body.text_part.decoded
    )
  end

  def mail_body
    @mail_body ||= mailer.constantize.with(musical:, person: @person).send(mail_method)
  end

  def client
    @client ||= begin
      config = {
        api_key: Rails.application.credentials.mailtrap_api_token,
        sandbox: Rails.env.development?,
        inbox_id: Rails.application.credentials.mailtrap_inbox_id,
        bulk: Rails.env.production?
      }.compact_blank

      Mailtrap::Client.new(**config)
    end
  end
end

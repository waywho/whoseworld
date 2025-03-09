class MusicalMailerService
  attr_reader :mail_method, :musical, :mailer, :receivers, :test
  
  def initialize(mail_method, musical:, mailer: nil, receivers: nil, test: false)
    @mail_method = mail_method
    @musical = musical
    @mailer = mailer
    @receivers = receivers
    @test = test
  end

  def send_mail
    composed_mails.each_slice(500) do |batch|
      client.send_batch(base_request, composed_mails)
    end
  end

  private

  def sendees
    if test
      BURM::Person.where(email: "walzerfan@yahoo.com")
    elsif !receivers.blank?
      receivers
    else
      BURM::Person.all
    end
  end

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
      category: mail_method.to_s
    }
  end

  def composed_mails
    Array(sendees).map do |person|
      if use_template?
        template_compose(person)
      else
        mailer_compose(person)
      end
    end
  end

  def client
    @client ||= begin
      BatchMailClient.new
    end
  end

  def mailer_compose(person)
    Mailtrap::Mail::Base.new(
      **"Mailers::#{mailer}Parser".constantize.parse(musical, person, mail_method)
    )
  end

  def template_compose(person)
    Mailtrap::Mail::FromTemplate.new(
      **"Mailtrap::#{mail_method.to_s.camelcase}Parser".constantize.parse(musical, person)
    )
  end

  def use_template?
    mailer.nil?
  end
end

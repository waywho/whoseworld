class MusicalMailJob < ApplicationJob
  queue_as :default

  def perform(mail_method, musical, test: false)
    receivers = BURM::Person.where(email: "weihsi.hu@gmail.com") if test
    MusicalMailerService.new("BURM::MuiscalMailer", mail_method, musical, receivers:).send_mail
  end
end

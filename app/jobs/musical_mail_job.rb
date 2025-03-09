class MusicalMailJob < ApplicationJob
  queue_as :default

  def perform(mail_method, musical, mailer: nil, test: false)
    MusicalMailerService.new(mail_method, musical:, mailer:, test:).send_mail
  end
end

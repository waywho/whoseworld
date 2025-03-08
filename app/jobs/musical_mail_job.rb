class MusicalMailJob < ApplicationJob
  queue_as :default

  def perform(mail_method, musical, test: false)
    MusicalMailerService.new("BURM::MusicalsMailer", mail_method, musical:, test:).send_mail
  end
end

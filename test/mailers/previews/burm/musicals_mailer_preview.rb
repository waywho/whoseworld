# Preview all emails at http://localhost:3000/rails/mailers/burm/musicals_mailer
class BURM::MusicalsMailerPreview < ActionMailer::Preview
  def announcement
    musical = BURM::Musical.last
    person = BURM::Person.last

    BURM::MusicalsMailer.with(musical:, person:).announcement
  end
end

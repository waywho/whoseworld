# Preview all emails at http://localhost:3000/rails/mailers/burm/musicals_mailer
class BURM::MusicalsMailerPreview < ActionMailer::Preview
  def next_musical
    musical = BURM::Musical.last
    person = BURM::Person.last

    BURM::MusicalsMailer.with(musical:, person:).next_musical
  end
end

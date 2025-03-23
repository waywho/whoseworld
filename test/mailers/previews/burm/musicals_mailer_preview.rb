# Preview all emails at http://localhost:3000/rails/mailers/burm/musicals_mailer
class BURM::MusicalsMailerPreview < ActionMailer::Preview
  def next_musical
    musical = BURM::Musical.last
    person = BURM::Person.last

    BURM::MusicalsMailer.with(musical:, person:).next_musical
  end

  def role_assignments
    musical = BURM::Musical.last
    person = BURM::Person.last

    BURM::MusicalsMailer.with(musical:, person:).role_assignments
  end

  def joining_instruction
    musical = BURM::Musical.last
    person = BURM::Person.last

    BURM::MusicalsMailer.with(musical:, person:).joining_instruction
  end
end

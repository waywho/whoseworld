# Preview all emails at http://localhost:3000/rails/mailers/burm/mailings_mailer
class BURM::NewslettersMailerPreview < ActionMailer::Preview
  def new_subscription
    person = BURM::Person.new(
      id: SecureRandom.uuid,
      first_name: "Tom",
      last_name: "Hiddleston",
      email: "tom@gmail.com"
    )

    BURM::NewslettersMailer.with(person:).new_subscription
  end
end

class Mailtrap::SignupOpenParser
  TEMPLATE_UUID = "3ce81755-54a6-4b5d-b488-9ae372183863"

  def self.parse(musical, person)
    {
      to: [{
        email: person.email,
        name: person.full_name
      }],
      template_uuid: TEMPLATE_UUID,
      template_variables: {
        musical: {
          title: musical.title,
          signupOpenAt: musical.signup_open_at,
          signupUrl: musical.signup_url,
          fee: musical.fee_with_currency
        },
        user: {
          firstName: person.first_name,
          unsubscribeUrl: person.unsubscribe_url
        }
      }
    }
  end
end

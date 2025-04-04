FactoryBot.define do
  factory :burm_signup, class: "BURM::Signup" do
    association :person, factory: :burm_person
    association :musical, factory: :burm_musical
    role { nil }
    alternative_role { nil }
    commit_to_pay { true }
    agree_to_emails { true }

    trait :with_role do
      after(:build) do |signup|
        signup.role = build(:burm_role, musical: signup.musical)
      end
    end
  end
end

FactoryBot.define do
  factory :burm_signup, class: "BURM::Signup" do
    association :person, factory: :burm_person
    association :musical, factory: :burm_musical
    alternative_role { nil }

    after(:build) do |signup|
      signup.role = build(:burm_role, musical: signup.musical)
    end
  end
end

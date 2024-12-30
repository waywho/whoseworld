FactoryBot.define do
  factory :burm_signup, class: "Burm::Signup" do
    association :person, factory: :burm_person
    association :role, factory: :burm_role
    association :musical, factory: :burm_musical
    alternative_role { nil }
  end
end

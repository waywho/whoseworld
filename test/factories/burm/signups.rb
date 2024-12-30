FactoryBot.define do
  factory :burm_signup, class: "Burm::Signup" do
    association :person, factory: :burm_person
    association :role, factory: :burm_role
    association :show, factory: :burm_show
    alternative_role { nil }
  end
end

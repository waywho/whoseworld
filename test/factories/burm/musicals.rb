FactoryBot.define do
  factory :burm_musical, class: "BURM::Musical" do
    title { Faker::Movie.title }
    start_at { "2024-12-30 15:54:48" }
    end_at { nil }
    location { "MyString" }
    fee { 15.00 }
    signup_start_at { Time.current - 1.day }

    after(:build) do |musical|
      musical.end_at = musical.start_at + 6.hours
    end

    trait :with_roles do
      after(:build) do |musical|
        musical.roles << build(:burm_role, musical:)
      end
    end
  end
end

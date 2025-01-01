FactoryBot.define do
  factory :burm_role, class: "BURM::Role" do
    name { Faker::Movies::LordOfTheRings.character }
    association :musical, factory: :burm_musical
    voice_type { BURM::Role.voice_types.keys.sample }
    role_type { BURM::Role.role_types.keys.sample }
  end
end

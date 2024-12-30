FactoryBot.define do
  factory :burm_role, class: "Burm::Role" do
    name { Faker::Movies::LordOfTheRings.character }
    association :musical, factory: :burm_musical
    voice_type { Burm::Role.voice_types.keys.sample }
    type { Burm::Role.types.keys.sample }
  end
end

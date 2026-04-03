FactoryBot.define do
  factory :burm_role, class: "BURM::Role" do
    sequence(:name) { |n| "#{Faker::Movies::LordOfTheRings.character} #{n}" }
    association :musical, factory: :burm_musical
    voice_type { BURM::Role.voice_types.keys.sample }
    role_type { BURM::Role.role_types.keys.sample }
  end
end

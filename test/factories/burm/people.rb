FactoryBot.define do
  factory :burm_person, class: "BURM::Person" do
    first_name { Faker::TvShows::Simpsons.character.split(" ").first }
    last_name { Faker::TvShows::Simpsons.character.split(" ").last }
    sequence :email do |n|
      "person#{n}@example.com"
    end
    voice_type { BURM::Person.voice_types.keys.sample }
    agree_to_terms { true }
    agree_to_emails { true }
  end
end

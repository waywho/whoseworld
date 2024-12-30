FactoryBot.define do
  factory :burm_person, class: "Burm::Person" do
    first_name { Faker::TvShows::Simpsons.character.split(" ").first }
    last_name { Faker::TvShows::Simpsons.character.split(" ").last }
    sequence :email do |n|
      "person#{n}@example.com"
    end
  end
end

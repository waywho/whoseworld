FactoryBot.define do
  factory :burm_musical, class: 'BURM::Musical' do
    title { Faker::Movie.title }
    start_at { "2024-12-30 15:54:48" }
    end_at { "2024-12-30 15:54:48" }
    location { "MyString" }
    fee { 15.00 }
  end
end

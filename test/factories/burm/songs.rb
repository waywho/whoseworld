FactoryBot.define do
  factory :burm_song, class: 'BURM::Song' do
    burm_musical { nil }
    order { 1 }
    title { "MyString" }
  end
end

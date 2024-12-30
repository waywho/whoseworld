FactoryBot.define do
  factory :burm_show, class: "Burm::Show" do
    title { Faker::Movie.title }
    start_at { "2024-12-29 00:02:52" }
    end_at { "2024-12-29 00:02:52" }
    location { "MyString" }
    fee { 15.00 }
  end
end

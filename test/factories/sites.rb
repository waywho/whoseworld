FactoryBot.define do
  factory :site do
    name { "MyString" }
    domain { Faker::App.name }
    subdomain { "MyString" }
    orientation { "MyString" }
    slug { "MyString" }
    subtitle { "MyString" }
    template_style { "MyString" }
  end
end

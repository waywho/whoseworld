FactoryBot.define do
  factory :site do
    name { "MyString" }
    domain { Faker::App.name }
    subdomain { "MyString" }
    orientation { "MyString" }
    slug { "MyString" }
    subtitle { "MyString" }
    template_style { "MyString" }

    trait :weihsi do
      name { "WeiHsi Hu" }
      domain { "weihsihu.com"}
      subdomain { nil }
      slug { "weihsihu" }
      orientation { "left" }
      subtitle { "Great site" }
      template_style { "one_page" }
    end

    trait :logical do
      name { "Logical Thinking" }
      domain { "logical-thinking.com" }
      subdomain { nil }
      slug { "logical-thinking" }
      orientation { "top" }
      subtitle { "Great site" }
      template_style { "multi_page" }
    end
  end
end

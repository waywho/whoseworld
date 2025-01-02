FactoryBot.define do
  factory :site do
    name { "MyString" }
    domain { "#{Faker::App.name.downcase}.com" }
    subdomain { "MyString" }
    nav_position { :top }
    slug { "my_string" }
    subtitle { "MyString" }
    layout_style { :one_page }

    trait :weihsi do
      name { "WeiHsi Hu" }
      domain { "weihsihu.com"}
      subdomain { nil }
      slug { "weihsihu" }
      nav_position { :left }
      subtitle { "Great site" }
      layout_style { :one_page }
    end

    trait :logical do
      name { "Logical Thinking" }
      domain { "logical-thinking.com" }
      subdomain { nil }
      slug { "logical-thinking" }
      nav_position { :top }
      subtitle { "Great site" }
      layout_style { :multi_page }
    end

    trait :example do
      name { "Example" }
      domain { "example.com" }
      subdomain { nil }
      slug { "example" }
      nav_position { :top }
      subtitle { "Great site" }
      layout_style { :multi_page }
    end
  end
end

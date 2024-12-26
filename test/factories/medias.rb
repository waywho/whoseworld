FactoryBot.define do
  factory :media do
    title { "MyString" }
    source { "MyText" }
    page
    site
    media_type { "MyString" }
    row_order { 1 }
  end
end

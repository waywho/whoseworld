FactoryBot.define do
  factory :media do
    title { "MyString" }
    source { "MyText" }
    page
    site { nil }
    media_type { Media.media_types.keys.sample }
    row_order { 1 }
  end
end

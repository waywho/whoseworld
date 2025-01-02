FactoryBot.define do
  factory :page do
    title { "MyString" }
    menu { false }
    slug { "MyString" }
    site
    row_order { 1 }
    template { Page.templates.keys.sample }
  end
end

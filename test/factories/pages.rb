FactoryBot.define do
  factory :page do
    title { "MyString" }
    kind { Page.kinds.except(:landing).keys.sample }
    slug { "MyString" }
    site
    row_order { 1 }
    template { Page.templates.keys.sample }
  end
end

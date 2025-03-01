FactoryBot.define do
  factory :address do
    house_number { 1 }
    road { "MyString" }
    town { "MyString" }
    city { "MyString" }
    county { "MyString" }
    state_district { "MyString" }
    state { "MyString" }
    postcode { "MyString" }
    country { "MyString" }
    country_code { "MyString" }
    lat { "MyString" }
    lon { "MyString" }
    boundingbox { "MyText" }
  end
end

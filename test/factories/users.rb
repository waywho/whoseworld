FactoryBot.define do
  factory :user do
    email { "MyString" }
    password { "MyString" }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2024-12-26 21:14:28" }
    remember_created_at { "2024-12-26 21:14:28" }
    admin { false }
  end
end

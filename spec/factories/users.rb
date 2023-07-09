FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    introduction { "テストデータです" }
    email { "test@test.com" }
    password { "password" }
  end
end

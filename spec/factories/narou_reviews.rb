FactoryBot.define do
  factory :narou_review do
    content { "MyText" }
    user_id { 1 }
    narou_id { 1 }
    created_at { Date.today }
  end
end

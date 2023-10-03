FactoryBot.define do
  factory :review do
    content { "MyText" }
    book_id { 1 }
    user_id { 1 }
    created_at { Date.today }
  end
end

FactoryBot.define do
  factory :query do
    association :user
    association :address
    content { "MyText" }
    budget { 1.5 }
    occupants { 1 }
    due_date { Time.now }
    name { "MyString" }
  end
end

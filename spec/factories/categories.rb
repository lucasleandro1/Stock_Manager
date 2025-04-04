FactoryBot.define do
  factory :category do
    name { "Tintas" }
    association :user
  end
end

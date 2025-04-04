FactoryBot.define do
  factory :customer do
    name { "Tinta Azul" }
    description { "tinta externa azul" }
    price { 10 }
    sku { "238748129348213" }
    category_id { 1 }
    user_id { 1 }
  end
end

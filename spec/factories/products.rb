# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { "Tinta Azul" }
    description {  }
    price { 10 }
    sku {  }
    category
    user
  end
end

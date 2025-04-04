FactoryBot.define do
  factory :product do
    name { "Tinta Azul" }
    description { "tinta externa azul" }
    price { 10 }
    sku { "238748129348213" }
    association :category  # Associa uma categoria automaticamente
    association :user      # Associa um usuário automaticamente
  end
end

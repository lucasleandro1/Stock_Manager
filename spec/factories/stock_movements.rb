FactoryBot.define do
  factory :stock_movement do
    price { "Tinta Azul" }
    quantity { 2 }
    movement_type { :entrada }
  end
end

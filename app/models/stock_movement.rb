class StockMovement < ApplicationRecord
  belongs_to :product

  enum :movement_types, entrada: 0, saida: 1
end

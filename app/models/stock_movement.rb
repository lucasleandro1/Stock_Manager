class StockMovement < ApplicationRecord
  belongs_to :product

  attribute :movement_type, :integer, default: 0
  enum :movement_type, entrada: 0, saida: 1
end

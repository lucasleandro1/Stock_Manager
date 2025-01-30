class StockMovement < ApplicationRecord
  belongs_to :product

  enum movement_type: { entrada: 0, saida: 1 }
  enum reason: { venda: 0, reposição: 1 }
end

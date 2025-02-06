class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :user
  attribute :movement_type, :integer, default: 0
  enum :movement_type, entrada: 0, saida: 1
  attribute :reason, :integer, default: 0
  enum :reason, venda: 0, reposição: 1

  validate :sufficient_stock, if: -> { movement_type == "saida" }

  private

  def sufficient_stock
    if product.stock_quantity < quantity
      errors.add(:quantity, "não há estoque suficiente")
    end
  end
end

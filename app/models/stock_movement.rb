class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :user
  attribute :movement_type, :integer, default: 0
  enum :movement_type, entrada: 0, saida: 1
  attribute :reason, :integer, default: 0
  enum :reason, venda: 0, reposição: 1

  after_create :update_product_quantity

  validate :sufficient_stock, if: -> { movement_type == "saida" }

  private

  def sufficient_stock
    if product.stock_quantity < quantity
      errors.add(:quantity, "não há estoque suficiente")
    end
  end

  def update_product_quantity
    case movement_type
    when 'entrada'
      valor = product.price * 1.7
      product.update!(price: valor)
      product.increment!(:stock_quantity, quantity)
    when 'saida'
      product.decrement!(:stock_quantity, quantity)
    end
  end
  
end

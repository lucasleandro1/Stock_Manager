class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :user
  attribute :movement_type, :integer, default: 0
  enum :movement_type, entrada: 0, saida: 1
  attribute :reason, :integer, default: 0
  enum :reason, venda: 0, reposição: 1
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :sufficient_stock, if: -> { movement_type == "saida" }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  private

  def sufficient_stock
    if product.stock_quantity < quantity
      errors.add(:quantity, "não há estoque suficiente")
    end
  end

  def self.lucro_por_mes
    stock_movements = where(created_at: 1.year.ago..Time.current).includes(:product)
    stock_movements.group_by { |sm| sm.created_at.strftime("%B %Y") }.transform_values do |movimentacoes|movimentacoes.sum do |sm|
        next 0 unless sm.product
        if sm.movement_type == "saida"
          sm.quantity * sm.product.price
        elsif sm.movement_type == "entrada"
          -sm.price
        else
          0
        end
      end.to_f
    end
  end
end

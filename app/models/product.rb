class Product < ApplicationRecord
  has_many :stock_movements, dependent: :destroy
  belongs_to :user
  belongs_to :category

  def lucro_total
    compras = stock_movements.where(movement_type: :entrada).sum(:price)
    vendas = stock_movements.where(movement_type: :saida).sum { |sm| sm.quantity * sm.product.price }
    vendas - compras
  end
end

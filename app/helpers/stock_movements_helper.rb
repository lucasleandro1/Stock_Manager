module StockMovementsHelper
  def sum(stock_movement)
    stock_movement.quantity * stock_movement.product.price
  end
end

class AddPriceToStockMovements < ActiveRecord::Migration[8.0]
  def change
    add_column :stock_movements, :price, :decimal
  end
end

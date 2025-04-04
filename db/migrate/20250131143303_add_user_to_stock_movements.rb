class AddUserToStockMovements < ActiveRecord::Migration[8.0]
  def change
    add_reference :stock_movements, :user, null: false, foreign_key: true
  end
end

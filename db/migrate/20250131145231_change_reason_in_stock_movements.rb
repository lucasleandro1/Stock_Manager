class ChangeReasonInStockMovements < ActiveRecord::Migration[8.0]
  def change
    change_column :stock_movements, :reason, :integer
  end
end

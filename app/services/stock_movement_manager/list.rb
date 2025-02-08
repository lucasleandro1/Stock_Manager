module StockMovementManager
  class List
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      stock_movement = @user.stock_movements.order(created_at: :desc)
      if @params[:search].present? && @params[:search][:product_id].present?
        stock_movement = stock_movement.where(product_id: @params[:search][:product_id])
      end
      stock_movement
    end
  end
end

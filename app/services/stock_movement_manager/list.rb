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

      if @params[:search].present? && @params[:search][:movement_type].present?
        stock_movement = stock_movement.where(movement_type: @params[:search][:movement_type])
      end

      stock_movement
    end
  end
end

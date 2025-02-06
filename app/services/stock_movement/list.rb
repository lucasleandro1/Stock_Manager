module StockMovementManager
  class List
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      stock_movement = @user.stock_movement.order(created_at: :desc)
      stock_movement
    end
  end
end

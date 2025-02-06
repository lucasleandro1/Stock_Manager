module StockMovementManager
  class Creator
    attr_reader :user, :stock_movement_params

    def initialize(user, stock_movement_params)
      @user = user
      @stock_movement_params = stock_movement_params
    end

    def call
      if stock_movement_exists
        response_error(message: "activerecord.errors.messages.stock_movement_exists")
      else
        response(create_stock_movement)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: "activerecord.errors.messages.stock_movement_created", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def create_stock_movement
      stock_movement = user.stock_movements.new(stock_movement_params)
      if stock_movement.save
        stock_movement
      else
        raise StandardError, stock_movement.errors.full_messages.to_sentence
      end
    end
  end
end

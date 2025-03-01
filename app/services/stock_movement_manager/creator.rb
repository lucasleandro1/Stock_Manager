module StockMovementManager
  class Creator
    attr_reader :user, :stock_movement_params

    def initialize(user, stock_movement_params)
      @user = user
      @stock_movement_params = stock_movement_params
    end

    def call
      ActiveRecord::Base.transaction do
        stock_movement = create_stock_movement
        update_stock(stock_movement)
        response(stock_movement)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.messages.stock_movement_created"), resource: data }
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

    def update_stock(stock_movement)
      product = stock_movement.product
      if stock_movement.entrada?
        product.increment!(:stock_quantity, stock_movement.quantity)
      else
        product.decrement!(:stock_quantity, stock_movement.quantity)
      end
    end
  end
end

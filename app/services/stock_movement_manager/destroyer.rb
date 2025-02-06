module StockMovementManager
  class Destroyer
    attr_reader :stock_movement_id

    def initialize(stock_movement_id)
      @stock_movement_id = stock_movement_id
    end

    def call
      response(scope)
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.stock_movement_delete"), resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def scope
      @stock_movement = StockMovement.find(stock_movement_id)
      unless @stock_movement.destroy
        raise StandardError.new(stock_movement.errors.full_messages.to_sentence)
      end
    end
  end
end

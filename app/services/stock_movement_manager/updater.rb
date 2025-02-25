module StockMovementManager
  class Updater
    attr_reader :stock_movement_params, :stock_movement_id

    def initialize(stock_movement_id, stock_movement_params)
      @stock_movement_id = stock_movement_id
      @stock_movement_params = stock_movement_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error(I18n.t("activerecord.errors.messages.stock_movement_notfound: #{e.message}"))
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.stock_movement_update."), resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @stock_movement = StockMovement.find(stock_movement_id)

      if @stock_movement_params[:arquivos].present?
        @stock_movement.arquivos.attach(@stock_movement_params[:arquivos])
      end

      unless @stock_movement.update(stock_movement_params.except(:arquivos))
        raise StandardError.new(@stock_movement.errors.full_messages.to_sentence)
      end
    end
  end
end

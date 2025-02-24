module CustomerManager
  class Destroyer
    attr_reader :customer_id

    def initialize(customer_id)
      @customer_id = customer_id
    end

    def call
      response(scope)
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.client_delete"), resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def scope
      @customer = Customer.find(customer_id)
      unless @customer.destroy
        raise StandardError.new(customer.errors.full_messages.to_sentence)
      end
    end
  end
end

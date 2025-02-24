module CustomerManager
  class Updater
    attr_reader :customer_params, :customer_id

    def initialize(customer_id, customer_params)
      @customer_id = customer_id
      @customer_params = customer_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error(I18n.t("activerecord.errors.messages.customer_notfound: #{e.message}"))
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.customer_update."), resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @customer = Customer.find(customer_id)
      unless @customer.update(customer_params)
        raise StandardError.new(customer.errors.full_messages.to_sentence)
      end
    end
  end
end

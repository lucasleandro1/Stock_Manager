module CustomerManager
  class Creator
    attr_reader :user, :customer_params

    def initialize(user, customer_params)
      @user = user
      @customer_params = customer_params
    end

    def call
      if customer_exists
        response_error(message: "activerecord.errors.messages.customer_exists")
      else
        response(create_customer)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.messages.customer_created"), resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def customer_exists
      user.customers.exists?(cpf_cnpj: customer_params[:cpf_cnpj])
    end

    def create_customer
      customer = user.customers.new(customer_params)
      if customer.save
        customer
      else
        raise StandardError, customer.errors.full_messages.to_sentence
      end
    end
  end
end

module CategoryManager
  class Destroyer
    attr_reader :category_id

    def initialize(category_id)
      @category_id = category_id
    end

    def call
      response(scope)
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.messages.category_delete"), resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def scope
      @category = Category.find(category_id)
      unless @category.destroy
        raise StandardError.new(category.errors.full_messages.to_sentence)
      end
    end
  end
end

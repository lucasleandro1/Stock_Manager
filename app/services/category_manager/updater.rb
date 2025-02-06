module CategoryManager
  class Updater
    attr_reader :category_params, :category_id

    def initialize(category_id, category_params)
      @category_id = category_id
      @category_params = category_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error(I18n.t("activerecord.errors.messages.category_notfound: #{e.message}"))
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.category_update."), resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @category = Category.find(category_id)
      unless @category.update(category_params)
        raise StandardError.new(category.errors.full_messages.to_sentence)
      end
    end
  end
end

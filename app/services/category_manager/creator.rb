module CategoryManager
  class Creator
    attr_reader :user, :category_params

    def initialize(user, category_params)
      @user = user
      @category_params = category_params
    end

    def call
      if category_exists
        response_error(message: "activerecord.errors.messages.category_exists")
      else
        response(create_category)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: "activerecord.errors.messages.category_created", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def category_exists
      user.categories.exists?(name: category_params[:name])
    end

    def create_category
      category = user.categories.new(category_params)
      if category.save
        category
      else
        raise StandardError, category.errors.full_messages.to_sentence
      end
    end
  end
end

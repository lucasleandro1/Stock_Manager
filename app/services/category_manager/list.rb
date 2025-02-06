module CategoryManager
  class List
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      categories = @user.categories.order(created_at: :desc)
      categories
    end
  end
end

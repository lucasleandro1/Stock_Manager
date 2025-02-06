module ProductManager
  class List
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      products = @user.products.order(created_at: :desc)

      if @params[:search].present? && @params[:search][:category_id].present?
        products = products.where(category_id: @params[:search][:category_id])
      end

      products
    end
  end
end

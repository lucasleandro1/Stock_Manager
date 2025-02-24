module CustomerManager
  class List
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      customers = @user.customers.order(created_at: :desc)
      if @params[:search].present? && @params[:search][:category_id].present?
        customers = customers.where(category_id: @params[:search][:category_id])
      end
      customers
    end
  end
end

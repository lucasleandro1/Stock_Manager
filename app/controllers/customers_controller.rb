class CustomersController < ApplicationController
  before_action :authenticate_user!

  def new
    @customer = Customer.new
  end

  def index
    @customers = CustomerManager::List.new(current_user, params).call.page(params[:page]).per(10)
  end

  def create
    service = CustomerManager::Creator.new(current_user, customer_params)
    result = service.call
    if result[:success]
      redirect_to customers_path, notice: result[:message]
    else
      @customer = Customer.new(customer_params)
      flash[:alert] = result[:error_message]
      render :new
    end
  end

  def show
    @customer = current_user.customers.find(params[:id])
  end

  def update
    update_service = CustomerManager::Updater.new(params[:id], customer_params)
    result = update_service.call

    if result[:success]
      redirect_to customers_path, notice: "Cliente atualizado com sucesso."
    else
      flash[:alert] = result[:error_message]
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @customer = current_user.customers.find(params[:id])
  end

  def destroy
    destroy_service = CustomerManager::Destroyer.new(params[:id])
    result = destroy_service.call
    if result[:success]
      redirect_to customers_path, notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      redirect_to customers_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :cpf_cnpj, :phone, :email, :address)
  end
end

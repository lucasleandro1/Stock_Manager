class ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.new
  end

  def index
    @products = ProductManager::List.new(current_user, params).call.page(params[:page]).per(10)
    @categories = Category.all
  end

  def create
    service = ProductManager::Creator.new(current_user, product_params)
    result = service.call
    if result[:success]
      redirect_to products_path, notice: result[:message]
    else
      @product = Product.new(product_params)
      flash[:alert] = result[:error_message]
      render :new
    end
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def update
    update_service = ProductManager::Updater.new(params[:id], product_params)
    result = update_service.call

    if result[:success]
      redirect_to products_path, notice: "Produto atualizado com sucesso."
    else
      flash[:alert] = result[:error_message]
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def destroy
    destroy_service = ProductManager::Destroyer.new(params[:id])
    result = destroy_service.call
    if result[:success]
      redirect_to products_path, notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      redirect_to products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:id, :name, :description, :sku, :price, :stock_quantity, :category_id)
  end
end

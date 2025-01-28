class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @product = @user.product.order(created_at: :desc)
  end

  def new
    @product = current_user.product.build
  end

  def create
    @product = current_user.product.build(product_params)
    if @product.save
      flash[:notice] = "product created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering product."
      render :new
    end
  end

  def show
    @product = current_user.product.find(params[:id])
    @comment = @product.comments
  end

  def update
    @product = current_user.product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "product atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "product não atualizado."
      render :edit
    end
  end

  def edit
    @product = current_user.product.find(params[:id])
  end

  def destroy
    @product = current_user.product.find(params[:id])
    @product.destroy
    redirect_to product_path, notice: 'product excluído com sucesso.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :price, :stock_quantity)
  end
end
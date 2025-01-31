class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @products = @user.products.order(created_at: :desc)
  end

  def new
    @products = current_user.products.build
  end

  def create
    @products = current_user.products.build(products_params)
    if @products.save
      flash[:notice] = "products created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering products."
      render :new
    end
  end

  def show
    @products = current_user.products.find(params[:id])
  end

  def update
    @products = current_user.products.find(params[:id])
    if @products.update(products_params)
      flash[:notice] = "products atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "products não atualizado."
      render :edit
    end
  end

  def edit
    @products = current_user.products.find(params[:id])
  end

  def destroy
    @products = current_user.products.find(params[:id])
    @products.destroy
    redirect_to products_path, notice: "products excluído com sucesso."
  end

  private

  def products_params
    params.require(:product).permit(:id, :name, :description, :sku, :price, :stock_quantity, :category_id)
  end
end

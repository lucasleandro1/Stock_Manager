class StockMovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @stock_movements = @user.stock_movements.order(created_at: :desc)
  end

  def new
    @stock_movements = current_user.stock_movements.build
  end

  def create
    @stock_movements = current_user.stock_movements.build(stock_movements_params)
    if @stock_movements.save
      flash[:notice] = "stock_movements created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering stock_movements."
      render :new
    end
  end

  def show
    @stock_movements = current_user.stock_movements.find(params[:id])
  end

  def update
    @stock_movements = current_user.stock_movements.find(params[:id])
    if @stock_movements.update(stock_movements_params)
      flash[:notice] = "stock_movements atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "stock_movements não atualizado."
      render :edit
    end
  end

  def edit
    @stock_movements = current_user.stock_movements.find(params[:id])
  end

  def destroy
    @stock_movements = current_user.stock_movements.find(params[:id])
    @stock_movements.destroy
    redirect_to stock_movements_path, notice: "stock_movements excluído com sucesso."
  end

  private

  def stock_movements_params
    params.require(:stock_movement).permit(:id, :quantity, :movement_type, :reason, :product_id)
  end
end

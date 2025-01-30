class StockMovementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @stockmoviment = @user.stockmoviment.order(created_at: :desc)
  end

  def new
    @stockmoviment = current_user.stockmoviment.build
  end

  def create
    @stockmoviment = current_user.stockmoviment.build(stockmoviment_params)
    if @stockmoviment.save
      flash[:notice] = "stockmoviment created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering stockmoviment."
      render :new
    end
  end

  def show
    @stockmoviment = current_user.stockmoviments.find(params[:id])
  end

  def update
    @stockmoviment = current_user.stockmoviment.find(params[:id])
    if @stockmoviment.update(stockmoviment_params)
      flash[:notice] = "stockmoviment atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "stockmoviment não atualizado."
      render :edit
    end
  end

  def edit
    @stockmoviment = current_user.stockmoviment.find(params[:id])
  end

  def destroy
    @stockmoviment = current_user.stockmoviment.find(params[:id])
    @stockmoviment.destroy
    redirect_to stockmoviments_path, notice: "stockmoviment excluído com sucesso."
  end

  private

  def stockmoviment_params
    params.require(:stockmoviment).permit(:id, :quantity, :movement_type, :reason, :product_id)
  end
end

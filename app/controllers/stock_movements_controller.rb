class StockMovementsController < ApplicationController
  before_action :authenticate_user!

  def new
    @stock_movement = StockMovement.new
  end

  def index
    @stock_movements = StockMovementManager::List.new(current_user, params).call.page(params[:page]).per(10)
  end

  def create
    service = StockMovementManager::Creator.new(current_user, stock_movement_params)
    result = service.call
    if result[:success]
      redirect_to stock_movements_path, notice: result[:message]
    else
      @stock_movement = StockMovement.new(stock_movement_params)
      flash[:alert] = result[:error_message]
      render :new
    end
  end

  def show
    @stock_movement = current_user.stock_movement.find(params[:id])
  end

  def update
    update_service = StockMovementManager::Updater.new(params[:id], stock_movement_params)
    result = update_service.call
    if result[:success]
      redirect_to stock_movements_path, notice: "Movimentação atualizado com sucesso."
    else
      flash[:alert] = result[:error_message]
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @stock_movement = current_user.stock_movements.find(params[:id])
  end

  def destroy
    destroy_service = StockMovementManager::Destroyer.new(params[:id])
    result = destroy_service.call
    if result[:success]
      redirect_to stock_movements_path, notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      redirect_to stock_movements_path
    end
  end

  private

  def stock_movement_params
    params.require(:stock_movement).permit(:id, :quantity, :movement_type, :reason, :price, :product_id)
  end
end

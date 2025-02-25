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
    @stock_movement = StockMovement.find(params[:id])
    service = StockMovementManager::Updater.new(@stock_movement.id, stock_movement_params)
    result = service.call
  
    if result[:success]
      redirect_to edit_stock_movement_path(@stock_movement), notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      render :edit
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

  def remove_file
    @stock_movement = StockMovement.find(params[:id])
    arquivo = @stock_movement.arquivos.find(params[:arquivo_id])

    if arquivo.purge
      redirect_to edit_stock_movement_path(@stock_movement), notice: "Arquivo excluído com sucesso."
    else
      redirect_to edit_stock_movement_path(@stock_movement), alert: "Erro ao excluir o arquivo."
    end
  end

  private

  def stock_movement_params
    params.require(:stock_movement).permit(:product_id, :quantity, :movement_type, :reason, :customer_id, :price, arquivos: [])
  end
end

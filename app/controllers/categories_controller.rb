class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.new
  end

  def index
    @categories = CategoryManager::List.new(current_user, params).call.page(params[:page]).per(10)
  end

  def create
    service = CategoryManager::Creator.new(current_user, categories_params)
    result = service.call
    if result[:success]
      redirect_to categories_path, notice: result[:message]
    else
      @category = Category.new(categories_params)
      flash[:alert] = result[:error_message]
      render :new
    end
  end

  def update
    update_service = CategoryManager::Updater.new(params[:id], categories_params)
    result = update_service.call
    if result[:success]
      redirect_to categories_path, notice: "Produto atualizado com sucesso."
    else
      flash[:alert] = result[:error_message]
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def destroy
    destroy_service = CategoryManager::Destroyer.new(params[:id])
    result = destroy_service.call
    if result[:success]
      redirect_to categories_path, notice: result[:message]
    else
      flash[:alert] = result[:error_message]
      redirect_to categories_path
    end
  end

  private

  def categories_params
    params.require(:category).permit(:id, :name)
  end
end

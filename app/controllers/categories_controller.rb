class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = @user.categories.order(created_at: :desc)
  end

  def new
    @categories = current_user.categories.build
  end

  def create
    @categories = current_user.categories.build(categories_params)
    if @categories.save
      flash[:notice] = "categories created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering categories."
      render :new
    end
  end

  def show
    @categories = current_user.categories.find(params[:id])
  end

  def update
    @categories = current_user.categories.find(params[:id])
    if @categories.update(categories_params)
      flash[:notice] = "categories atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "categories não atualizado."
      render :edit
    end
  end

  def edit
    @categories = current_user.categories.find(params[:id])
  end

  def destroy
    @categories = current_user.categories.find(params[:id])
    @categories.destroy
    redirect_to categories_path, notice: "categories excluído com sucesso."
  end

  private

  def categories_params
    params.require(:category).permit(:id, :name)
  end
end

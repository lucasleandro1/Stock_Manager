class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @category = @user.category.order(created_at: :desc)
  end

  def new
    @category = current_user.category.build
  end

  def create
    @category = current_user.category.build(category_params)
    if @category.save
      flash[:notice] = "category created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering category."
      render :new
    end
  end

  def show
    @category = current_user.categories.find(params[:id])
  end

  def update
    @category = current_user.category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "category atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "category não atualizado."
      render :edit
    end
  end

  def edit
    @category = current_user.category.find(params[:id])
  end

  def destroy
    @category = current_user.category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "category excluído com sucesso."
  end

  private

  def category_params
    params.require(:category).permit(:id, :name)
  end
end

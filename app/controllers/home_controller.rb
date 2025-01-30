class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search].present? && params[:search][:category_id].present?
      @products = Product.where(category_id: params[:search][:category_id])
    else
      @products = Product.all
    end
    @categories = Category.all
  end
end

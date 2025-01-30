class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.order(created_at: :desc)
  end
end

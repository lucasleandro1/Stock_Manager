class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @movimentacoes_recentes = StockMovement.order(created_at: :desc).limit(5)

    @vendas_por_mes = StockMovement
    .where(created_at: 1.year.ago..Time.current)
    .group_by_month(:created_at, format: "%B %Y")
    .sum(:movement_type)

    @lucro = StockMovement
      .where(created_at: 1.year.ago..Time.current)
      .group_by_month(:created_at, format: "%B %Y")
      .sum { |movimentacao|movimentacao.product.lucro_total }
      

      @lucro_por_mes = StockMovement.lucro_por_mes.to_h


  end
end

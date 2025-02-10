class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_produtos = Product.count
    @movimentacoes_recentes = StockMovement.order(created_at: :desc).limit(5)


    @vendas_por_mes = StockMovement
    .where(created_at: 1.year.ago..Time.current)
    .group_by_month(:created_at, format: "%B %Y")
    .sum(:movement_type)

    @lucro_por_mes = StockMovement
      .where(created_at: 1.year.ago..Time.current)
      .group_by_month(:created_at, format: "%B %Y")
      .sum { |movimentacao|movimentacao.product.lucro_total }
  end
end

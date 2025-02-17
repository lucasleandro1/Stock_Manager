class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @movimentacoes_recentes = StockMovement.order(created_at: :desc).limit(5)

    @vendas_por_mes = StockMovement
    .where(created_at: 1.year.ago..Time.current)
    .group_by_month(:created_at, format: "%B %Y")
    .sum(:movement_type)

    @lucro = StockMovement.lucro_por_mes.values.sum
    @lucro_por_mes = StockMovement.lucro_por_mes.to_h
    @lucro_por_dia = StockMovement.lucro_por_dia.to_h
    @lucro_por_ano = StockMovement.lucro_por_ano.to_h

    @top_products = StockMovement
    .where(movement_type: "saida", created_at: 1.year.ago..Time.current)
    .group(:product_id)
    .select("product_id, SUM(quantity) AS total_quantity")
    .joins(:product)
    .order("total_quantity DESC")
    .limit(5)
  end
end

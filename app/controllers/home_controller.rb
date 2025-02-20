class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
    @movimentacoes_recentes = current_user.stock_movements.order(created_at: :desc).limit(5)

    @vendas_por_mes = current_user.stock_movements
      .where(created_at: 1.year.ago..Time.current)
      .group_by_month(:created_at, format: "%B %Y")
      .sum(:movement_type)

    @lucro = current_user.stock_movements.lucro_por_mes.values.sum
    @lucro_por_mes = current_user.stock_movements.lucro_por_mes.to_h
    @lucro_por_dia = current_user.stock_movements.lucro_por_dia.to_h
    @lucro_por_ano = current_user.stock_movements.lucro_por_ano.to_h

    @top_products = current_user.stock_movements
      .where(movement_type: "saida", created_at: 1.year.ago..Time.current)
      .group(:product_id)
      .select("product_id, SUM(quantity) AS total_quantity")
      .joins(:product)
      .order("total_quantity DESC")
      .limit(5)

    @monthly_entries = current_user.stock_movements
      .where(movement_type: "entrada", created_at: 1.year.ago..Time.current)
      .group_by_month(:created_at, format: "%b %Y")
      .sum(:price)

    @low_stock_products = current_user.products.where("stock_quantity < ?", 10)
  end
end

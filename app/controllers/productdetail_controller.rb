class ProductdetailController < ApplicationController
  def index
  end

  def show
    @product_color = ProductColor.find(params[:id])
    @product = Product.where(id: @product_color.product_id)
    @sizes = Size.where(product_color_id: params[:id]).where('has_stock != 0')
    @order_item = current_order.order_items.new
  end
end

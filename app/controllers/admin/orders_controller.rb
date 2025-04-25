class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = @order_details.sum { |order_detail| order_detail.price * order_detail.amount }
  end
end

class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save
      redirect_to thanks_orders_path
    else
      @customer = current_customer
      render :confirm
    end
  end

  def index
  end

  def show
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
  end

  def thanks
  end
end

private

def order_params
  params.require(:order).permit(
    :last_name,
    :first_name,
    :last_name_kana,
    :first_name_kana,
    :postal_code,
    :address,
    :telephone_number,
    :payment_method)
end

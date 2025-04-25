class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = current_customer.orders.new(order_params)

    cart_items = current_customer.cart_items
    shopping_cost = 800
    total_price = cart_items.sum { |item| item.item.price * item.amount }

    @order.total_payment = total_price + shopping_cost
    @order.shopping_cost = shopping_cost

    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.save!
      end

      current_customer.cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      @customer = current_customer
      render :confirm
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

    @total_price = @order_details.sum { |order_detail| order_detail.price * order_detail.amount }
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @customer = current_customer
    @shopping_cost = 800
    @total_price = @cart_items.sum { |cart_item| cart_item.item.price * cart_item.amount }
    @total_payment = @total_price + @shopping_cost
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

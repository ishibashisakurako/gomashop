class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
  end

  def index
  end

  def show
  end

  def confirm
  end

  def thanks
  end
end

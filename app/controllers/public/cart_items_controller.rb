class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = current_customer.cart_items.find_or_initialize_by(item: @item)
    @cart_item.amount = cart_item_params[:amount].to_i + (@cart_item.amount || 0)
    if @cart_item.save
      redirect_to cart_items_path, notice: "カートに追加しました！"
    else
      redirect_back fallback_location: root_path, alert: "カート追加に失敗しました。"
    end
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end  

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end

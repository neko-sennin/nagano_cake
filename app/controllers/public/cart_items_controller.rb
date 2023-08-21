class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!
  
  
  def index
    @cart_items = current_customer.cart_items
  end
  
  def create
    @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      flash[:success] = "カートに存在するアイテムです。"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:success] = "カートに追加しました。"
        redirect_to cart_items_path
      else
        flash[:danger] = "予期せぬエラーが発生しました。"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = "個数を変更しました。"
      redirect_to cart_items_path
    else
      flash[:danger] = "正しい個数を入力してください。"
      redirect_to cart_items_path
    end
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    flash[:success] = "カートの中身を空にしました。"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "選択された商品を削除しました。"
    redirect_to cart_items_path
  end

  
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end

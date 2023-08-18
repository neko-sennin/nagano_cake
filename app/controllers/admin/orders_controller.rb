class Admin::OrdersController < ApplicationController
  
  def index
    @order = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_price)
  end
  
end

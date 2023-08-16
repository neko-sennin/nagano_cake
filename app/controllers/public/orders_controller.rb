class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.tax_included_price
        order_detail.save
      end
        @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def check
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = current_customer.orders.new(order_params)
    if params[:order][:address_option] == "0"
      @order.order_profile(current_customer.postal_code, current_customer.address, current_customer.last_name+current_customer.first_name)
    elsif params[:order][:address_option] == "1"
      @order.order_profile(params[:order][:postal_code], params[:order][:address], params[:order][:name])
    end
    unless @order.valid?
      flash[:danger] = "お届け先の内容に不備があります"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def thanks
  end
 
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_price)
  end
  
end

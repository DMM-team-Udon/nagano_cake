class Customer::OrdersController < ApplicationController
  def new
    @order = Order.new
    @order_address = current_customer.shipping_addresses
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.save

    ## order_detailsに情報を記録
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.product_id = cart_item.product_id
      @order_detail.order_id = @order.id
      @order_detail.quantity = cart_item.quantity
      @order_detail.price = cart_item.product.with_tax_price
      @order_detail.production_status = 0
      @order_detail.save
    end
    ## カート内商品を全て消去
    current_customer.cart_items.destroy_all
    redirect_to success_orders_path
  end

  def confirm
    @order = Order.new(order_params)
    ## 支払い方法どちらを選択したか
    @order.payment_method = params[:order][:payment_method]
    ## total_priceの算出
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    @order.postage = 800
    @order.total_price = @order.postage.to_i + @total.round.to_i
    ## 配送先どれを選んだか
    if params[:order][:select_address] == "0"
      ## 自分の住所を選択した場合
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      ## 登録した配送先を選択した場合
      @address = ShippingAddress.find(params[:order][:dear_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      ## 配送先新規登録を選択した場合
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def success
  end

  def index
    @order = current_customer.orders
    @order = Order.page(params[:page]).per(8)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :postage, :total_price, :customer_id, :status)
  end

  def orderdetail_params
    params.require(:order_detail).permit(:product_id, :order_id, :quantity, :price, :production_status)
  end

end

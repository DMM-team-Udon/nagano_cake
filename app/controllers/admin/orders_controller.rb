class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update #注文ステータスの更新
  @order = Order.find(params[:id])
  @order.update(order_params)
  if @order.payment_confirm?
    @order.order_details.each do |order_detail|
      order_detail.waiting_production!
    end
  end
  redirect_to admin_order_path
  end

  private

  def order_params
     params.require(:order).permit( :payment_method,:status,)
  end

end

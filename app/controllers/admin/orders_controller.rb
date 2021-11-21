class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    if order.update(order_params)
      if order.status == " payment_confirm"
         order_details.each { |order_detail|
         order_detail.update_attributes(production_status: "waiting_productio")
         }
      end

      redirect_to admin_order_path(order)
    else
      redirect_to request.referer
    end
  end

  private

  def order_params
     params.require(:order).permit( :payment_method,:status,)
  end

end

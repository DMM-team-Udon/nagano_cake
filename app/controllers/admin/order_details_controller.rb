class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
      @order_detail = OrderDetail.find(params[:id])
      @order = @order_detail.order
      @order_details = @order_detail.order.order_details
      @order_detail.update(order_detail_params)
      if @order_detail.in_production?
          @order.making!
      elsif @order_details.count == @order_details. production_complete.count
          @order. ready_to_ship!
      end
      redirect_to admin_order_path(@order_detail.order)
  end

    private
     def order_detail_params
       params.permit(:production_status)
     end
end
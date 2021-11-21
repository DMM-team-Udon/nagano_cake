class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

   def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)


    # order_status:　now_cooking→制作中　now_packing→発送準備中   make_status:   now_cooking→制作中　complete_cooking→制作完了

      case @order_detail.production_status
        when "in_production"
          @order.update_attributes(order_status: "making")
        when "production_complete"
          if @order.order_details.all?{ |order_detail| order_detail.production_status == "production_complete" }
             @order.update_attributes(order_status: "ready_to_ship")
          end
      end

      redirect_to admin_order_path(@order_detail.order)
    else
      redirect_to request.referer
    end
   end

    private
     def order_detail_params
       params.permit(:production_status)
     end
end
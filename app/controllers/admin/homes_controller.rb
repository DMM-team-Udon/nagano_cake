class Admin::HomesController < ApplicationController

     before_action :authenticate_admin!

  def top
    @orders = Order.all
    @orders = Order.page(params[:page]).reverse_order
  end
end

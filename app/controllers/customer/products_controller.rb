class Customer::ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(8)
    @total_products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = current_customer.cart_items.new
  end
end

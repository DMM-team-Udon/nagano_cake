class Customer::ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(8)
    @total_products = Product.all
    @genre = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = current_customer.cart_items.new
    @genre = Genre.all
  end
end

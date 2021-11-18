class Customer::ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(8)
    @total_products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end

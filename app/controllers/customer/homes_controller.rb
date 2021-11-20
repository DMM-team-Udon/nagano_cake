class Customer::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @products = Product.order(created_at: :desc).limit(4)
  end

  def about
  end
end

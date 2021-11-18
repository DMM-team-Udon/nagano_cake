class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "商品の新規登録完了"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product =Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品の編集完了"
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end

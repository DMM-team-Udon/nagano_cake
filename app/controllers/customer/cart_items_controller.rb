class Customer::CartItemsController < ApplicationController
  def index
    ##@cart_items = current_customer.cart_items.all
    @cart_items = CartItem.all
    ## 合計金額の算出
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end

  def create
    @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
  ## 追加した商品がカート内に存在するかの判別
    if @cart_item.present?
    ## 存在した場合
      ## カート内の個数をフォームから送られた個数分追加する
      @cart_item.quantity += params[:quantity].to_i
      @cart_item.save
      redirect_to cart_items_path, notice: "商品の数量を追加しました。"
    else
    ## 存在しなかった場合
      ## カートモデルにレコードを新規作成する
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path, notice: "商品を追加しました。"
    end
  end

  def update
    ## 数量の変更
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: "商品の数量を変更しました。"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "商品をショッピングカートから削除しました。"
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path, notice: "カート内の商品を全て削除しました。"
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :customer_id, :quantity)
  end

end

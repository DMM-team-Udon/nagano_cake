class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  ## 小計を求めるメソッド
  def subtotal
    product.with_tax_price * quantity
  end

end

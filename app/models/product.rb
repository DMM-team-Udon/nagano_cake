class Product < ApplicationRecord
  belongs_to :genre
  
  attachment :image
  
  validates :name, :introduction, :price, :is_active
  
  has_many :cart_items, dependent: :destroy
  has_many :order, through: :order_detail
  
  ## 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end

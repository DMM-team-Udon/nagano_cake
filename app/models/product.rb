class Product < ApplicationRecord
  belongs_to :genre

  attachment :image


  validates :name, :introduction, :price, presence: true

  has_many :cart_items, dependent: :destroy
  has_many :order, through: :order_detail



  ## 消費税を求めるメソッド
  def with_tax_price
    (self.price * 1.1).floor
  end

end

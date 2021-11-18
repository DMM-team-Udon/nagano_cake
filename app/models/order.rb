class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :product, through: :product
end

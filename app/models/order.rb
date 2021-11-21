class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :product, through: :product

  belongs_to :customer


  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { wait_for_deposit: 0, payment_confirm: 1, making: 2, ready_to_ship: 3, shipped: 4 }
end

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy

  belongs_to :customer

  validates :postage, :total_price, :payment_method, :status, :name, :address, presence: true
  validates :postal_code, presence: true, length: { is: 7 }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_for_deposit: 0, payment_confirm: 1, making: 2, ready_to_ship: 3, shipped: 4 }
end

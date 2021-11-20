class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :shipping_addresses, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :phone_number, presence: true, length: { in: 10..11 }
  validates :address, presence: true
end

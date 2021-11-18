class Product < ApplicationRecord
  belongs_to :genre
  
  attachment :image
  
  validates :name, :introduction, :price, presence: true
  
  def add_tax
    (self.price * 1.1).round
  end
end
class Product < ApplicationRecord
  belongs_to :genre
  
  attachment :image
  
  validates :name, :introduction, :price, :is_active
end

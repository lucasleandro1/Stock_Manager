class Product < ApplicationRecord
  has_many :stock_movements, dependent: :destroy 
  belongs_to :user
  belongs_to :category
end

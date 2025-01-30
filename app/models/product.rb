class Product < ApplicationRecord
  has_many :stock_movements
  belongs_to :user
  belongs_to :category
end

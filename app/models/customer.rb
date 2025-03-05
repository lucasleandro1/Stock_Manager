class Customer < ApplicationRecord
  has_many :stock_movements
  validates :name, presence: true
  belongs_to :user
end

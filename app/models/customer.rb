class Customer < ApplicationRecord
  has_many :stock_movements, dependent: :nullify
  validates :name, presence: true
  belongs_to :user
end
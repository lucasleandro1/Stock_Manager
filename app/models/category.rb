class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true
  belongs_to :user
end

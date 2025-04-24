class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :order_details
  has_many :orders, through: :order_details
end

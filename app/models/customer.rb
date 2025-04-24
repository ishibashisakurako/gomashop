class Customer < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :active_customers, -> { where(is_active: true) }
  scope :withdrawal_customers, -> { where(is_active: false) }
end
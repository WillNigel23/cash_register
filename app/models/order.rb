# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :name, :address, presence: true
end

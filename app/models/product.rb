# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :text
#  name        :string           not null
#  price       :decimal(8, 2)    default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_code  (code) UNIQUE
#  index_products_on_name  (name) UNIQUE
#
class Product < ApplicationRecord
  has_many :cart_products
  has_many :carts, through: :cart_products

  validates :name, :code, presence: true, db_uniqueness: true
end

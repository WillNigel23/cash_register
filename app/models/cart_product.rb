# == Schema Information
#
# Table name: cart_products
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_cart_products_on_cart_id                 (cart_id)
#  index_cart_products_on_cart_id_and_product_id  (cart_id,product_id) UNIQUE
#  index_cart_products_on_product_id              (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id) ON DELETE => cascade
#  fk_rails_...  (product_id => products.id) ON DELETE => cascade
#
class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, db_uniqueness: { scope: :cart_id }
end

# == Schema Information
#
# Table name: order_products
#
#  id           :bigint           not null, primary key
#  actual_price :decimal(8, 2)    default(0.0), not null
#  quantity     :integer          default(1), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#  product_id   :bigint           not null
#
# Indexes
#
#  index_order_products_on_order_id                 (order_id)
#  index_order_products_on_order_id_and_product_id  (order_id,product_id) UNIQUE
#  index_order_products_on_product_id               (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id) ON DELETE => cascade
#  fk_rails_...  (product_id => products.id) ON DELETE => cascade
#
class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, db_uniqueness: { scope: :order_id }
end

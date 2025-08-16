class CreateOrderProductsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: { on_delete: :cascade }
      t.references :product, null: false, foreign_key: { on_delete: :cascade }
      t.integer :quantity, null: false, default: 1
      t.decimal :actual_price, precision: 8, scale: 2, default: 0, null: false

      t.timestamps
    end

    add_index :order_products, [ :order_id, :product_id ], unique: true
  end
end

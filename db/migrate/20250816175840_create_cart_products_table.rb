class CreateCartProductsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_products do |t|
      t.references :cart, null: false, foreign_key: { on_delete: :cascade }
      t.references :product, null: false, foreign_key: { on_delete: :cascade }
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end

    add_index :cart_products, [ :cart_id, :product_id ], unique: true
  end
end

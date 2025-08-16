class CreateProductsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.string  :code, null: false
      t.text    :description
      t.decimal :price, precision: 8, scale: 2, default: 0, null: false

      t.timestamps

      t.index :name, unique: true
      t.index :code, unique: true
    end
  end
end

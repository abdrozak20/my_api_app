class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :category_code
      t.string :name
      t.integer :size
      t.integer :stock
      t.string :unit
      t.text :description
      t.decimal :purchase_price
      t.string :image_path
      t.string :created_by
      t.string :updated_by

      t.timestamps
      t.index :code, unique: true, name: 'categories_unique'
    end
  end
end

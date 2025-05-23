class TransactionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :transaction_items do |t|
      t.string :transaction_code
      t.string :product_code
      t.integer :qty, default: 0
      t.decimal :price
      t.text :notes
      t.string :created_by
      t.string :updated_by
      t.timestamps
      t.index :transaction_code, name: 'transaction_item_code_idx'
      t.index :product_code, name: 'product_item_code_idx'
    end
  end
end

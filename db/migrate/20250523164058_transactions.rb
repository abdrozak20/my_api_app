class Transactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_code
      t.string :transaction_type, limit: 10
      t.string :customer_name
      t.string :supplier_name
      t.text :notes
      t.string :created_by
      t.string :updated_by
      t.timestamps
      t.index :transaction_code, unique: true, name: 'transaction_code_unique'
    end
  end
end

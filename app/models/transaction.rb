class Transaction < ApplicationRecord
    has_many :transaction_items, foreign_key: 'transaction_code', primary_key: 'transaction_code'
end
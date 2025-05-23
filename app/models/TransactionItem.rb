class TransactionItem < ApplicationRecord
    belongs_to :transactions, class_name: "Transaction", foreign_key: 'transaction_code', primary_key: 'transaction_code'
end

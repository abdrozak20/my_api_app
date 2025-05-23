class TransactionRepository
  def self.create(payload)
    Transaction.create!(payload)
  end

  def self.create_item(payload)
    TransactionItem.create!(payload)
  end
end
require 'securerandom'

class TransactionsController < ApplicationController
  def store
    if params[:type] == 'IN'
      process_incoming_transaction(params)
    else
      process_outcoming_transaction(params)
    end
    render json: {
      message: 'Success'
    }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def process_incoming_transaction(parameters)
    supplier_name = parameters[:supplier_name]
    type = parameters[:type]
    ActiveRecord::Base.transaction do
      transaction_code = "#{type}-#{SecureRandom.hex(6).upcase}"
      payload = {
        transaction_code: transaction_code,
        transaction_type: type,
        supplier_name: type,
        created_by: @current_user.username
      }
      TransactionRepository.create(payload)

      params[:products].each do |item|
        product = ProductRepository.find_by_code(item[:product_code])
        if product.nil?
          raise StandardError, "Product with code #{item[:product_code]} not found"
        end
        item_payload = {
          transaction_code: transaction_code,
          product_code: item[:product_code],
          qty: item[:qty],
          price: item[:price],
          created_by: @current_user.username
        }
        TransactionRepository.create_item(item_payload)

        product_payload = {
          purchase_price: item[:price],
          stock: item[:qty] + product.stock,
          created_by: @current_user.username
        }
        ProductRepository.update(product.id, product_payload)
      end
    end
  end

  def process_outcoming_transaction(parameters)
  end
end

class ProductsController < ApplicationController
  # GET /products
  def index
    result = {
      message: "Success",
      data: [],
      recordsTotal: 0,
      recordsFiltered: 0,
      draw: params[:draw].to_i
    }

    begin
      products = ProductRepository.datatable(params)
      result[:data] = products[:data]
      result[:recordsTotal] = products[:recordsTotal]
      result[:recordsFiltered] = products[:recordsFiltered]
      render json: result, status: :ok
    rescue => e
      render json: {
        message: e.message
      }, status: :internal_server_error
    end
  end

  # GET /products/1
  def show
    begin
      data = ProductRepository.find_by_id(params[:id])
      render json: {
        message: "Success",
        data: data
      }, status: :ok
    rescue => e
      render json: {
        message: e.message
      }, status: :internal_server_error
    end
  end

  # POST /products
  def create
    begin
      required_keys = [:name, :category_code, :size, :unit]
      validated_params = product_params(required_keys)
    
      product_name = params[:name]
      category_code = params[:category_code]
      size = params[:size]
      stock = 0
      unit = params[:unit]
      description = params[:description]
      purchase_price = 0
      product_code = Helper.generate_product_code(product_name, category_code, size)
      image_path = nil
      
      payload = Helper.generate_payload_create_product(product_code, category_code, product_name, size, unit, stock, description, purchase_price, @current_user.username, image_path)
      product = ProductRepository.create(payload)
      if product.save
        render json: {
          message: 'Success'
        }, status: :created
      else
        render json: {
          message: product.errors
        }, status: :unprocessable_entity
      end
    rescue => e
      render json: {
        message: e.message
      }, status: :internal_server_error
    end
  end

  # PATCH/PUT /products/1
  def update
    begin
      required_keys = [:name, :category_code, :size, :unit]
      validated_params = product_params(required_keys)

      product = ProductRepository.find_by_id(params[:id])
      if product.nil?
        render json: {
          message: "Product not found"
        }, status: :not_found
        return
      end

      product_code = product.code
      product_name = params[:name]
      category_code = params[:category_code]
      size = params[:size]
      stock = product.stock
      unit = params[:unit]
      description = params[:description]
      purchase_price = product.purchase_price
      image_path = nil
      
      payload = Helper.generate_payload_create_product(product_code, category_code, product_name, size, unit, stock, description, purchase_price, @current_user.username, image_path)
      update = ProductRepository.update(params[:id], payload)
      if update
        render json: {
          message: 'Success'
        }, status: :ok
      else
        render json: {
          message: 'Update failed'
        }, status: :unprocessable_entity
      end
    rescue => e
      render json: {
        message: e.message
      }, status: :internal_server_error
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def product_params(required_keys)
      missing_keys = required_keys.select { |key| params[key].blank? }
      if missing_keys.any?
        raise ActionController::ParameterMissing.new("Missing required parameters: #{missing_keys.join(', ')}")
      end
      params.permit(:name, :code, :category_code, :size, :unit, :description)
    end
end

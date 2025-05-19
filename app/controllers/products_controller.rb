class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    validated_params = product_params
    
    product_name = params[:name]
    category_code = params[:category_code]
    size = params[:size]
    stock = 0
    unit = params[:unit]
    description = params[:description]
    purchase_price = 0
    product_code = Helper.generate_product_code(product_name, category_code, size)
    
    payload = Helper.generate_payload_create_product(product_code, category_code, product_name, size, unit, stock, description, purchase_price, @current_user.username)
    @product = ProductRepository.create(payload)
    if @product.save
      render json: {
        message: 'Success'
      }, status: :created
    else
      render json: {
        message: @product.errors
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      required_keys = [:name, :category_code, :size, :unit]

      missing_keys = required_keys.select { |key| params[key].blank? }
      if missing_keys.any?
        raise ActionController::ParameterMissing.new("Missing required parameters: #{missing_keys.join(', ')}")
      end
      params.permit(:name, :category_code, :size, :unit, :description)
    end
end

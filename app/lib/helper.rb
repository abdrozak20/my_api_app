class Helper 
    def self.generate_product_code(product_name, category_code, size)
        products = ProductRepository.get_all
        counter = (products.count + 1).to_s.rjust(4, '0')
        combine_name = product_name.delete(' ')[0, 3].upcase
        product_code = "#{category_code}-#{combine_name}-#{size.delete(' ')}-#{counter}"
        product_code
    end

    def self.generate_payload_create_product(product_code, category_code, product_name, size, unit, stock, description, purchase_price, created_by)
        {
            code: product_code,
            name: product_name,
            category_code: category_code,
            size: size,
            stock: stock,
            unit: unit,
            description: description,
            purchase_price: purchase_price,
            created_by: created_by
        }
    end
    
end
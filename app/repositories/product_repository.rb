class ProductRepository
    def self.create(payload)
        Product.new(payload)
    end

    def self.get_all
        Product.all
    end

    def self.find_by_code(code)
        Product.find_by(code: code)
    end
end
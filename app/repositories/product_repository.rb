class ProductRepository
    def self.create(payload)
        Product.new(payload)
    end

    def self.update(id, payload)
        Product.update(id, payload)
    end

    def self.get_all
        Product.all
    end

    def self.find_by_id(id)
        Product.find(id)
    end

    def self.datatable(params)
        search = params[:search].to_s
        start = params[:start].to_i
        length = params[:length].to_i

        products = Product.joins(:category)
        .where('categories.name ILIKE :search OR products.name ILIKE :search OR products.size ILIKE :search', search: "%#{search}%")
        records_total = products.count

        data = products.select('products.*, categories.name as category_name')
        .order('products.id')
        .offset(start)
        .limit(length)

        {
            data: data,
            recordsTotal: records_total,
            recordsFiltered: records_total
        }
    end
    
end
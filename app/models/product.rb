class Product < ApplicationRecord
    belongs_to :category, foreign_key: 'category_code', primary_key: 'code'
end

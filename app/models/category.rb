class Category < ApplicationRecord
    has_many :products, foreign_key: 'category_code', primary_key: 'code'
end
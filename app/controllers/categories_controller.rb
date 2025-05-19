class CategoriesController < ApplicationController
    def get_all
        categories = Category.all
        
        if categories.empty?
            render json: { message: 'Category not found' }, status: :not_found
        else
            render json: { message: 'Success', data: categories }, status: :ok
        end
    end
end

class CategoriesController < ApplicationController
  

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.arrange_as_array({:order => 'name'})
  end

end

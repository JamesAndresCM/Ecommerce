class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_product, only: [:show]
  # GET /products
  # GET /products.json
  def index
    @product = Product.all.paginate(page: params[:page]).order(created_at: :desc)
    #render template: "admin/products/index"
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

end

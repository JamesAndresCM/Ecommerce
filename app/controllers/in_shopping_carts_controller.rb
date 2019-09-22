class InShoppingCartsController < ApplicationController

  before_action :set_product

  def create
    #in_shopping_cart = InShoppingCart.new(product_id: params[:product_id], shopping_cart: @shopping_cart)
    #@product = Product.find(params[:product_id])
    in_shopping_cart = @shopping_cart.add_product(@product)
    #in_shopping_cart = @shopping_cart.in_shopping_carts.create(product: Product.find(params[:product_id]))

    #render json: @shopping_cart.in_shopping_carts
    
    if in_shopping_cart.save
      render 'in_shopping_carts/create.js.erb'
      #redirect_to carrito_path, notice: "Producto guardado"
    else
      redirect_to products_path, notice: "No se agrego al carro.."
    end
  end

  def destroy
    @in_shopping_cart = InShoppingCart.find(params[:id])

    @in_shopping_cart.destroy

    redirect_to carrito_path
  end

  private

  def set_product
    begin
      @product = Product.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to products_path, notice: "Producto no existe"
    end
  end
end

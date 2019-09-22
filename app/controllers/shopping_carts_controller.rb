class ShoppingCartsController < ApplicationController

  def show
    if @shopping_cart.payed?
      render "shopping_carts/complete"
    end
  end

  def destroy
    @product_cart_id = params[:product_id]
    remove_product = InShoppingCart.where(shopping_cart: @shopping_cart).where(product_id: @product_cart_id).delete_all
  end
  
end

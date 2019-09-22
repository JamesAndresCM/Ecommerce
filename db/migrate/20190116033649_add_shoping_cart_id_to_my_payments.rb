class AddShopingCartIdToMyPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :my_payments, :shopping_cart, index: true
  end
end

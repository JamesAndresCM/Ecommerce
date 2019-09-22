class ChangeStatusToInShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    change_column :shopping_carts, :status, :string
  end
end

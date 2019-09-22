class AddQuantityToInShoppingCart < ActiveRecord::Migration[5.2]
  def change
    add_column :in_shopping_carts, :quantity, :integer, default: 1
  end
end

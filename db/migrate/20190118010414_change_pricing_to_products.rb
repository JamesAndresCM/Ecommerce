class ChangePricingToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :pricing, :decimal, precision: 8, scale: 2
  end
end

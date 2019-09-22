class ChangeFromDecimalToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :pricing, :integer
  end
end

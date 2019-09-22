# == Schema Information
#
# Table name: my_payments
#
#  id               :bigint(8)        not null, primary key
#  ip               :string
#  email            :string
#  fee              :decimal(6, 2)
#  paypal_id        :string
#  total            :decimal(8, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shopping_cart_id :bigint(8)
#  status           :string
#

class MyPayment < ApplicationRecord
  belongs_to :shopping_cart

  include AASM

  aasm column: "status" do
    state :created, initial: true
    state :payed
    state :failed

    event :pay do
      after do
        shopping_cart.pay!
        update_stock_product
      end
      transitions from: :created, to: :payed
    end
  end

  def update_stock_product
    self.shopping_cart.in_shopping_carts.map do |product|
      stock_product = (product.product.stock - product.quantity)
      Product.update(product.product_id, stock: stock_product)
    end
  end
end

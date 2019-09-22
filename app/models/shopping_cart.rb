# == Schema Information
#
# Table name: shopping_carts
#
#  id         :bigint(8)        not null, primary key
#  status     :string
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingCart < ApplicationRecord
  include AASM
  has_many :in_shopping_carts, -> { includes :product }
  has_many :products, through: :in_shopping_carts
  has_many :my_payments

  aasm column: "status" do
    state :created, initial: true
    state :payed
    state :failed

    event :pay do
      after do
        #Enviar orden de confirmacion
        SendProductsMailer.shipped(self,payment.email).deliver_later
      end
      transitions from: :created, to: :payed
    end
  end


  def items
    #self.products.map{|product| product.paypal_form }
    self.in_shopping_carts.map do |product_form|
      {
        name: product_form.product.name, 
        sku: :item, 
        price: ("%.2f" % product_form.product.pricing), 
        currency: "USD", 
        quantity: product_form.quantity
      }
    end
  end

  def total
    #products.sum(:pricing)
    in_shopping_carts.to_a.sum { |item| item.total_price }
  end

  def payment
    begin
      my_payments.payed.first
    rescue StandardError
      return nil
    end
  end


  def add_product(product)
    current_item = in_shopping_carts.find_by(product_id: product.id)
    if current_item
      current_item.quantity +=1
    else
      current_item = in_shopping_carts.build(product_id: product.id)
    end
    current_item
  end
end

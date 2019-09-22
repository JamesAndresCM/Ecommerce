# == Schema Information
#
# Table name: products
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  pricing     :decimal(8, 2)
#  description :text
#  user_id     :bigint(8)
#  img         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  stock       :integer
#

class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  self.per_page = 10
  delegate :username, to: :user, prefix: true
  belongs_to :user
  validates_presence_of :name, :pricing
  validates :pricing, numericality: { greather_than: 0 }

  #si relacion fuese en ambos sentidos HBTM , pero solo se hace en el sentido de ShoppingCart
  belongs_to :category
  has_many :in_shopping_carts
  has_many :shopping_carts, through: :in_shopping_carts
  
  before_destroy :ensure_not_referenced_by_any_in_shopping_cart

  def ensure_not_referenced_by_any_in_shopping_cart
    unless in_shopping_carts.empty?
      errors.add(:base, 'Producto esta presente en carro de compra')
      throw :abort
    end
  end

 # def paypal_form
 #   {name: name, sku: :item, price: (pricing / 100), currency: "USD", quantity: 1}
 # end
end

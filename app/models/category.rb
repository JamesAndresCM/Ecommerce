class Category < ApplicationRecord
  include Tree
  has_many :products
end

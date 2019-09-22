class AddStatusToMyPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :my_payments, :status, :string
  end
end

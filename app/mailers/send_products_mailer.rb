class SendProductsMailer < ApplicationMailer
  default from: "Rails Ecommerce #{ENV['EMAIL_USER']}"

  def shipped(order,user_mail)
    @order = order
    mail to: user_mail, subject: 'Recibo de confirmación de compra'
  end

end

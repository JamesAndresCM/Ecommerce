class PaymentsController < ApplicationController
  before_action :process_payment, only: %i(create process_card)
  before_action :ensure_cart_payed, only: [:payment_succed]

  def create
    if @paypal_helper.process_payment.create
      @my_payment = MyPayment.create!(paypal_id: @paypal_helper.payment.id, ip: request.remote_ip, shopping_cart_id: cookies[:shopping_cart_id], total: @shopping_cart.total)
      redirect_to @paypal_helper.payment.links.find{|v| v.method == "REDIRECT"}.href
    else
      raise @paypal_helper.payment.error.to_yaml
    end
  end


  def checkout
    @my_payment = MyPayment.find_by(paypal_id: params[:paymentId])

    if @my_payment.nil?
      redirect_to "/carrito"
    else
      Stores::Paypal.checkout(params[:PayerID],params[:paymentId]) do
        @my_payment.update(email: Stores::Paypal.get_email(params[:paymentId]))
        @my_payment.pay!
        redirect_to succeed_path, notice: "Se proceso el pago correctamente"
        return
      end
        redirect_to carrito_path, notice: "Error al pagar"
    end
  end

  def process_card
     if @paypal_helper.process_card(payment_card_params).create
      @my_payment = MyPayment.create!(paypal_id: @paypal_helper.payment.id, ip: request.remote_ip, email: params[:email],shopping_cart_id: cookies[:shopping_cart_id], total: @shopping_cart.total)
      @my_payment.pay!
      redirect_to succeed_path, notice: "El pago se realizo correctamente"
     else
       redirect_to carrito_path, notice: "Error al pagar"
     end   
  end

  def payment_succed; end

  private

  def payment_card_params
    params.permit(:email, :number, :cvv2, :expire_year, :expire_month)
  end

  def process_payment
    @paypal_helper = Stores::Paypal.new(
                    ("%.2f" % @shopping_cart.total),
                    @shopping_cart.items,
                    return_url: checkout_url, 
                    cancel_url: carrito_url,
                    description: "Compra en plataforma"
    ) 
  end
  
  def ensure_cart_payed
    if @shopping_cart.payed?
      cookies[:shopping_cart_id] = nil
    else
      redirect_to carrito_path
    end
  end

end

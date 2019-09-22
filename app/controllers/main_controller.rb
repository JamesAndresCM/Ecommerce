class MainController < ApplicationController
  layout 'main'

  def index
    @contact = Main.new(params[:main])
  end

  def create
    begin
      @contact = Main.new(params[:main])
      @contact.request = request
        if @contact.deliver
          @contact = Main.new
          redirect_to root_path, notice: "Thank you for your message. I'll get back to you soon!"
        else
          render :index, notice: "Error"
        end
    rescue ScriptError
      redirect_to root_path, notice: 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
end

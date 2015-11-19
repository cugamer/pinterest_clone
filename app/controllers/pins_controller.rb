class PinsController < ApplicationController
  def new
    @pin = Pin.new
  end
  
  def create
    @user = current_user
    @pin = @user.pins.new(pins_params)
    if @pin.save
      
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
  end
  
  private
    def pins_params
      params.require(:pin).permit(:title, :description)
    end
end

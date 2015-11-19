class PinsController < ApplicationController
  def new
    @pin = Pin.new
  end
  
  def create
    @user = current_user
    @pin = @user.pins.new(pins_params)
    if @pin.save
      flash[:success] = "Sucessfully pinned!"
      redirect_to @pin
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
    @pin = Pin.find(params[:id])
  end
  
  private
    def pins_params
      params.require(:pin).permit(:title, :description)
    end
end

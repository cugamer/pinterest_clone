class PinsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
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
    @pin = Pin.find(params[:id])
  end
  
  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(pins_params)
    redirect_to @pin
  end
  
  def show
    if Pin.exists?(params[:id])
      @pin = Pin.find(params[:id])
      @user = User.find(@pin.user_id)
      @comments = Comment.where(pin_id: @pin.id)
    else
      redirect_to no_pin_path
    end
      
  end
  
  def show_user
    @user = User.find(params[:user_id])
    @pins = @user.pins.last(20)
  end
  
  def destroy
    pin = Pin.find(params[:id])
    pin.destroy
    redirect_to user_pins_page_path(current_user.id)
  end
  
  private
    def pins_params
      params.require(:pin).permit(:title, :description, :pin_image)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(Pin.find_by(id: params[:id]).user_id)
      redirect_to(root_url) unless @user == current_user
    end
end

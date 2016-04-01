class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Pinterest Clone!"
      log_in @user
      redirect_to user_pins_page_path(@user.id)
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    
    @user = User.find(params[:id])
    
    if !check_for_protected(@user.email) && @user.update_attributes(user_params)
      flash[:success] = "Profile has been successfuly updated"
      redirect_to @user
    else
      if check_for_protected(@user.email)
        flash[:danger] = "This account cannot be edited"
      end
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:danger] = "Your account and all it's associated pins have been removed."
    logout
    redirect_to root_path
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end

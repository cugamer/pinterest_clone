class VotesController < ApplicationController
  before_action :logged_in_user
  
  def change_rating
    pin = Pin.find(params[:id])
    user = current_user
    vote = Vote.where(pin_id: pin.id, user_id: user.id)
    if !vote.exists?
      pin.rating += 1
      pin.save
      Vote.create(user_id: user.id, pin_id: pin.id)
    else
      vote.destroy_all
      pin.rating -=1
      pin.save
    end
    redirect_to pin_path(params[:id])
  end
  
  
  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
end

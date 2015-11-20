class VotesController < ApplicationController
  def vote_up
    @pin = Pin.find(params[:id])
    @pin.rating += 1
    @pin.save
    redirect_to pin_path(params[:id])
  end
end
